require 'logger'

module MojFileUploaderApiClient
  class HttpClient
    attr_accessor :response

    DEFAULT_OPTIONS = {
      headers: {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json',
        'x-amz-server-side-encryption' => 'AES256'
      },
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
      # Using `self.class.options` allows overriding defaults in individual API
      # calls and ensure that overrides do not persist across calls.
      DEFAULT_OPTIONS.merge(self.class.options || {})
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
      logger = Logger.new(STDOUT)
      begin
        res = RestClient::Request.execute(request_details)
        code, body = res.code, res.body
        logger.info("[api-client] Received request from uploader #{res.inspect}")
        logger.info("[api-client] res.code: #{code}, res.body: #{body}")
      rescue RestClient::Exception => ex
        code, body = ex.http_code, ex.response
        logger.info("[api-client] RestClient exception: #{ex.inspect}")
        logger.info("[api-client] RestClient raised exception with code: #{code}, body: #{body}")
      end

      self.response = Response.new(code: code, body: body)
    end
  end
end
