module MojFileUploaderApiClient
  class Response
    attr_accessor :code, :raw_body

    def initialize(code:, body:)
      @code = code
      @raw_body = body
    end

    def success?
      [200, 204].include?(code)
    end

    def error?
      !success?
    end

    def body
      @body ||= parse_body
    end

    private

    def parse_body
      return if raw_body.nil? || raw_body.empty?
      JSON.parse(raw_body, symbolize_names: true)
    rescue JSON::ParserError
      raise UnparsableResponseError.new('Invalid JSON response', raw_body)
    end
  end
end
