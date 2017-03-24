module MojFileUploaderApiClient
  class Status < MojFileUploaderApiClient::HttpClient

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
