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
  class Unavailable < StandardError; end
  class RequestError < StandardError; end
end
