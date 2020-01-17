require 'json'
require 'rest-client'
require 'mojfile_uploader_api_client/version'
require 'mojfile_uploader_api_client/errors'
require 'mojfile_uploader_api_client/response'
require 'mojfile_uploader_api_client/http_client'
require 'mojfile_uploader_api_client/file_reference'
require 'mojfile_uploader_api_client/status'
require 'mojfile_uploader_api_client/add_file'
require 'mojfile_uploader_api_client/delete_file'
require 'mojfile_uploader_api_client/list_files'
require 'logger'
require 'benchmark'

module MojFileUploaderApiClient
  INFECTED_FILE_RESPONSE_CODE = 400
  NOT_FOUND_RESPONSE_CODE = 404

  def self.add_file(params)
    response = AddFile.new(params).call

    if response.success?
      response.body
    elsif response.code.equal?(INFECTED_FILE_RESPONSE_CODE)
      raise InfectedFileError
    else
      raise RequestError.new('Could not add file', response.code, response.body)
    end
  end

  def self.delete_file(params)
    response = DeleteFile.new(params).call

    raise RequestError.new('Could not delete file', response.code, response.body) unless response.success?
    response.body
  end

  def self.list_files(params)
    logger = Logger.new(STDOUT)

    logger.info("[api-client] Send request to uploader with params #{params.inspect}")
    time = Benchmark.measure do
      @response = ListFiles.new(params).call
    end
    logger.info("[api-client] Benchmarking 'ListFiles.new(params).call': #{time}")
    logger.info("[api-client] Response successful: #{@response.success?}")

    if @response.success?
      @response.body
    elsif @response.code.equal?(NOT_FOUND_RESPONSE_CODE)
      raise NotFoundError
    else
      raise RequestError.new('Could not list files', @response.code, @response.body)
    end
  end
end
