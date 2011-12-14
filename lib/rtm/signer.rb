require 'digest/md5'

module RTM
  module Signer
    extend self

    def sign secret, request
      sorted_array_of_key_value_arrays = sort_hash(request)
      Digest::MD5.hexdigest(secret + join_arrays(sorted_array_of_key_value_arrays))
    end

    private

    def join_arrays array
      array.map { |key_value_array| key_value_array.join('') }.join('')
    end

    def sort_hash request
      request.sort
    end
  end
end