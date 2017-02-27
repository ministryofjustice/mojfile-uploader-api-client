require 'json'
require 'rest-client'
require 'mojfile_uploader_api_client/version'
require 'mojfile_uploader_api_client/response'
require 'mojfile_uploader_api_client/http_client'
require 'mojfile_uploader_api_client/file_reference'
require 'mojfile_uploader_api_client/status'
require 'mojfile_uploader_api_client/add_file'
require 'mojfile_uploader_api_client/delete_file'
require 'mojfile_uploader_api_client/list_files'

module MojFileUploaderApiClient
  INFECTED_FILE_RESPONSE_CODE = 400
  NOT_FOUND_RESPONSE_CODE = 404

  class Unavailable < StandardError; end
  class RequestError < StandardError; end
  class InfectedFileError < StandardError; end
  class NotFoundError < StandardError; end

  def self.add_file(params)
    response = AddFile.new(params).call

    if response.success?
      response.body
    elsif response.code.equal?(INFECTED_FILE_RESPONSE_CODE)
      raise InfectedFileError
    else
      raise RequestError
    end
  end

  def self.delete_file(params)
    response = DeleteFile.new(params).call

    raise RequestError unless response.success?
    response.body
  end

  def self.list_files(params)
    response = ListFiles.new(params).call

    if response.success?
      response.body
    elsif response.code.equal?(NOT_FOUND_RESPONSE_CODE)
      raise NotFoundError
    else
      raise RequestError
    end
  end
end
