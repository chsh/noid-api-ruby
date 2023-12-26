require 'noid/api'
require 'thor'

module Noid
  module Api
    class CLI < Thor
      desc "api_key", "show api_keyo"
      def api_key
        puts Config.config.api_key
      end
    end
  end
end
