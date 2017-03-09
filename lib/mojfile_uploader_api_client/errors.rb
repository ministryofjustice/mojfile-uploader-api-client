module MojFileUploaderApiClient
  class RequestError < StandardError
    attr_reader :code, :body

    def initialize(message, code, body)
      super(message)
      @code = code
      @body = body
    end
  end

  class UnparsableResponseError < RuntimeError
    attr_reader :raw_body

    def initialize(message, raw_body)
      super(message)
      @raw_body = raw_body
    end
  end

  class InfectedFileError < StandardError; end
  class NotFoundError < StandardError; end
end
