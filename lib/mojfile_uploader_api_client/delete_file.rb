module MojFileUploaderApiClient
  class DeleteFile < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref, :folder, :filename

    def initialize(collection_ref:, folder: nil, filename:)
      self.collection_ref = collection_ref
      self.folder = folder
      self.filename = filename
    end

    def verb
      :delete
    end

    def endpoint
      [collection_ref, folder, filename].compact.join('/')
    end
  end
end
