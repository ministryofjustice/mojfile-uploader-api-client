module MojFileUploaderApiClient
  class AddFile < MojFileUploaderApiClient::HttpClient
    attr_accessor :collection_ref, :folder, :filename, :data

    def initialize(collection_ref: nil, folder: nil, filename:, data:)
      self.collection_ref = collection_ref
      self.folder = folder
      self.filename = filename
      self.data = data
    end

    def verb
      :post
    end

    def payload
      payload = {file_filename: filename, file_data: data}
      payload[:folder] = folder if folder
      payload
    end

    def endpoint
      File.join(collection_ref.to_s, 'new')
    end
  end
end
