$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'mojfile_uploader_api_client/version'

Gem::Specification.new do |spec|
  spec.name = 'mojfile-uploader-api-client'
  spec.version = MojFileUploaderApiClient::VERSION
  spec.authors = ['Jesus Laiz', 'Tax Tribunals Fees']
  spec.email = ['jesus.laiz@digital.justice.gov.uk', 'taxtribsfees@digital.justice.gov.uk']

  spec.summary = 'API client for integration with the MOJ File Uploader'
  spec.homepage = 'https://github.com/ministryofjustice/mojfile-uploader-api-client'
  spec.licenses = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 0.2'
  spec.add_development_dependency 'mutant-rspec', '~> 0.8'
  spec.add_development_dependency 'pry-byebug', '~> 3.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.41'

  spec.add_dependency 'rest-client', '~> 2.0.0'
end
