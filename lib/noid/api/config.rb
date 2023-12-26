
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

    class ConfigLoader
      def load_config
        touch_config_path
        IniFile.load(config_path)
      end

      def config_path
        File.join(config_dir, 'config')
      end

      def touch_config_path
        return false if File.exists?(config_path)
        FileUtils.mkdir_p(config_dir)
        FileUtils.touch(config_path)
      end
    end
  end
end
