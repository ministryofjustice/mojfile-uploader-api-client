module MojFileUploaderApiClient
  class ListFiles < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref

    def initialize(collection_ref:)
      self.collection_ref = collection_ref
    end

    def verb
      :get
    end

    def endpoint
      collection_ref
    end
  end
end
