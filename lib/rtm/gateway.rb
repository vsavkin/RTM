require 'rest_client'
require 'json'
require_relative 'signer'

module RTM
  class Gateway
    AUTH_URL = "http://www.rememberthemilk.com/services/auth/"
    URL = "https://api.rememberthemilk.com/services/rest/"

    def initialize api_key, secret
      @api_key, @secret = api_key, secret
    end

    def generate_auth_link
      response = send_request 'method' => 'rtm.auth.getFrob', 'api_key' => @api_key, 'format' => 'json'
      parsed = JSON.parse(response)
      raise "Invalid Response #{response}" unless parsed['rsp']['stat'] == 'ok'
      frob = parsed['rsp']['frob']
      auth_parameters = build_request 'perms' => 'delete', 'frob' => frob

      parameters = auth_parameters.map { |k, v| "#{k}=#{v}" }.join("&")
      "#{AUTH_URL}?#{parameters}"
    end

    private
    def send_request request_hash
      request = build_request(request_hash)
      RestClient.get URL, :params => request
    end

    def send_auth_request request_hash
      request = build_request(request_hash)
      RestClient.get AUTH_URL, request
    end

    def build_request request_hash
      signed_request = RTM::Signer.sign @secret, request_hash
      request_hash.merge('api_key' => @api_key, 'api_sig' => signed_request)
    end
  end
end

gateway = RTM::Gateway.new("4486f9224a4a8fa8fef850482fc26160", "03b3b6dba031d1b2")
p gateway.generate_auth_link
