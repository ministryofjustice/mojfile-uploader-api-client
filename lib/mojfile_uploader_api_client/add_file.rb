module MojFileUploaderApiClient
  class AddFile < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref, :title, :filename, :data

    def initialize(collection_ref: nil, title:, filename:, data:)
      self.collection_ref = collection_ref
      self.title = title
      self.filename = filename
      self.data = data
    end

    def verb
      :post
    end

    def payload
      {file_title: title, file_filename: filename, file_data: data}
    end

    def endpoint
      File.join(collection_ref.to_s, 'new')
    end
  end
end
