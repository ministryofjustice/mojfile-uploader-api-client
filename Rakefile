# begin
#   require 'bundler/setup'
# rescue LoadError
#   puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
# end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'MojFileUploaderApiClient'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

# Get rid of rspec background noise.
task(:spec).clear
RSpec::Core::RakeTask.new(:spec) do |t|
  t.verbose = false
end
task default: :spec

load 'tasks/mutant.rake'
load 'tasks/rubocop.rake'
