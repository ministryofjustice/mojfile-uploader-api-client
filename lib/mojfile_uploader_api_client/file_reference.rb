# Note: Decide if go with building `file` objects or instead using the uploader API json response directly
#
module MojFileUploaderApiClient
  class FileReference
    attr_accessor :key, :title, :last_modified

    def initialize(key:, title:, last_modified:)
      self.key = key
      self.title = title
      self.last_modified = last_modified
    end
  end
end
