require 'rest_client'
require 'json'
require_relative 'signer'

module RTM
  class Gateway
    AUTH_URL = "http://www.rememberthemilk.com/services/auth/"
    URL = "https://api.rememberthemilk.com/services/rest/"

    def initialize api_key, secret, token = nil
      @api_key, @secret, @token = api_key, secret, token
    end

    def get_frob
      response = send_request 'method' => 'rtm.auth.getFrob'
      raise "Invalid Response #{response}" unless response['rsp']['stat'] == 'ok'
      response['frob']
    end

    def generate_auth_link frob
      parameters = build_auth_parameters frob
      "#{AUTH_URL}?#{parameters}"
    end

    def get_token frob
      send_request 'method' => 'rtm.auth.getToken', 'frob' => frob
    end

    
    def check_token
      send_request 'method' => 'rtm.auth.checkToken', 'auth_token' => @token
    end

    def get_all_lists
      send_request 'method' => 'rtm.lists.getList', 'auth_token' => @token
    end

    def get_tasks_from_list list_id
      send_request 'method' => 'rtm.tasks.getList', 'auth_token' => @token, 'list_id' => list_id
    end
    
    private
    def build_auth_parameters frob
      auth_parameters = build_signed_request 'perms' => 'delete', 'frob' => frob
      auth_parameters.map { |k, v| "#{k}=#{v}" }.join("&")
    end
    
    def send_request request_hash
      params = build_signed_request(request_hash.merge('format' => 'json'))
      response = RestClient.get(URL, :params => params)
      parsed = JSON.parse(response)
      parsed['rsp']
    end

    def send_auth_request request_hash
      request = build_request(request_hash)
      RestClient.get AUTH_URL, request
    end

    def build_signed_request request_hash
      result_hash = request_hash.merge('api_key' => @api_key)
      signed_request = RTM::Signer.sign @secret, result_hash
      result_hash.merge('api_sig' => signed_request)
    end
  end
end

token = "079c19ec8b7e364860288624da7a9cf416d310d1"
gateway = RTM::Gateway.new("4486f9224a4a8fa8fef850482fc26160", "03b3b6dba031d1b2", token)
list_id = "21338504"
#p gateway.generate_auth_link
#p gateway.get_token "07f7d888f935b1c936d0a8eaae64c6e8e35ee3e7"

#p gateway.check_token  "079c19ec8b7e364860288624da7a9cf416d310d1"
#p gateway.get_all_lists
p gateway.get_tasks_from_list(list_id)
