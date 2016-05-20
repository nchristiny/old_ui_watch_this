require 'rest-client'

module Api
  class Configuration
    # Defines both class and instance accessors for class attributes
    cattr_accessor :url
    cattr_accessor :version
    # cattr_accessor :current_authentication_token

    class << self
      def api
        @api ||= initialize_resource
      end

      private

      def initialize_resource
        # Create a resource pointing to the watch-this API, setting the desired version to the respective header.
        RestClient::Resource.new(url, headers: { accept: "application/vnd.watch-this.v#{version}, application/json" })
      end
    end
  end
end
