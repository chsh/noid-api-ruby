
require 'fileutils'

module Noid
  module Api
    class Config
      def self.config
        @@config ||= new
      end

      def initialize
      end

      def api_key
        config_content['API_KEY']
      end

      def config_content
        @config_content ||= begin
          parse File.read(File.join(config_dir, 'config'))
        end
      end

      def config_dir
        raise "no HOME env defined." unless ENV['HOME']
        dir = "#{ENV['HOME']}/.noid"
        FileUtils.mkdir(dir) unless Dir.exist?(dir)
        dir
      end

      def parse(content)
        h = {}
        lines = content.strip.split(/\n/).select { |line| line.length > 0 }
        lines.each do |line|
          next if line =~ /\A\s*#/
          next unless line =~ /\A(.+?)=(.+)\z/
          h[$1.strip] = $2.strip
        end
        h
      end
    end
  end
end
