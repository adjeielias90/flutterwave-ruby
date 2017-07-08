require 'net/https'
require 'uri'
require 'json'
require 'flutterwave/utils/constants'

module Flutterwave
  module Utils
    module NetworkManager
      BASE_URL = Flutterwave::Utils::Constants::BASE_URL

      def self.post(url, body)
        uri = URI.parse("#{BASE_URL}#{url}")
        request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
        request.body = body.to_json
        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = (uri.scheme == 'https')
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE if http.use_ssl?
        response = http.request(request)

        JSON.parse(response.body)
      rescue SocketError, TypeError, EOFError, JSON::ParserError => e
        return nil
      end
    end
  end
end
