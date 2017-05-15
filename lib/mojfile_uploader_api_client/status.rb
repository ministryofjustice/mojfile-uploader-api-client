module MojFileUploaderApiClient
  class Status < MojFileUploaderApiClient::HttpClient
    def self.options
      # Setting `timeout` will override both `read_timeout` and `open_timeout`
      # in the RestClient.
      { timeout: 5 }
    end

    def verb
      :get
    end

    def endpoint
      'status'
    end

    def available?
      response.success? && status.eql?('ok')
    end

    private

    def status
      response.body&.fetch(:service_status)
    end
  end
end
