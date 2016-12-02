module MojFileUploaderApiClient
  class HttpClient
    attr_accessor :response

    DEFAULT_OPTIONS = {
      headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json'},
      verify_ssl: false,
      open_timeout: 5,
      read_timeout: 15
    }.freeze

    class << self
      attr_accessor :base_url, :options

      def configure
        yield(self)
      end
    end

    def call
      execute_request
      response
    end

    def endpoint
      raise 'not implemented'
    end

    def verb
      raise 'not implemented'
    end

    def payload; end

    def payload?
      !payload.nil?
    end

    def options
      DEFAULT_OPTIONS.merge(HttpClient.options || {})
    end

    private

    def url
      File.join(HttpClient.base_url, endpoint)
    end

    def request_details
      {method: verb, url: url}.merge(options).tap do |args|
        args.merge!(payload: payload.to_json) if payload?
      end
    end

    def execute_request
      begin
        res = RestClient::Request.execute(request_details)
        code, body = res.code, res.body
      rescue RestClient::Exception => ex
        code, body = ex.http_code, ex.response
      end

      self.response = Response.new(code: code, body: body)
    end
  end
end
