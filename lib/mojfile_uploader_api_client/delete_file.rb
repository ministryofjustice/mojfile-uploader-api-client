module MojFileUploaderApiClient
  class DeleteFile < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref, :filename

    def initialize(collection_ref:, filename:)
      self.collection_ref = collection_ref
      self.filename = filename
    end

    def verb
      :delete
    end

    def endpoint
      [collection_ref, filename].join('/')
    end
  end
end
