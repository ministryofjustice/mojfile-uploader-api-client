module MojFileUploaderApiClient
  class Response
    attr_accessor :code, :body

    def initialize(code:, body:)
      self.code = code
      self.body = parse_body(body) if body
    end

    def success?
      [200, 204].include?(code)
    end

    def error?
      !success?
    end

    private

    def parse_body(body)
      JSON.parse(body, symbolize_names: true)
    rescue JSON::ParserError => ex
      {body_parser_error: ex.message}
    end
  end
end
