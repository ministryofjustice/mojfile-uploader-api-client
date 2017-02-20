module MojFileUploaderApiClient
  class Response
    class UnparsableResponseError < RuntimeError; end

    attr_accessor :code

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
      return if @raw_body.nil? || @raw_body.empty?
      JSON.parse(@raw_body, symbolize_names: true)
    rescue JSON::ParserError
      raise UnparsableResponseError
    end
  end
end
