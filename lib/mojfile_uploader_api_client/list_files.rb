module MojFileUploaderApiClient
  class ListFiles < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref, :folder

    def initialize(collection_ref:, folder: nil)
      self.collection_ref = collection_ref
      self.folder = folder
    end

    def verb
      :get
    end

    def endpoint
      [collection_ref, folder].compact.join('/')
    end
  end
end
