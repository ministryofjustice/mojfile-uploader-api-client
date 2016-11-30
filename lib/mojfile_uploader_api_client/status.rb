module MojFileUploaderApiClient
  class Status < MojFileUploaderApiClient::HttpClient

    def verb
      :get
    end

    def endpoint
      'status'
    end

    def available?
      status.eql?('OK')
    end

    private

    def status
      response.body&.fetch(:status)
    end
  end
end
