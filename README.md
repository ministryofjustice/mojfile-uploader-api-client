# mojfile-uploader-api-client
An API client for [mojfile-uploader](https://github.com/ministryofjustice/mojfile-uploader)

Please refer to the above project if you want to build your own client around the API.

## Configuration

In your project, create an initializer with the following:

```ruby
MojFileUploaderApiClient::HttpClient.configure do |client|
  client.base_url = 'http://localhost:3003' # mandatory
  client.options = {} # optional - supports :headers, :verify_ssl, :open_timeout, :read_timeout
end
```

## Operations

### Add a file

#### When a previous collection reference is known:

```ruby
MojFileUploaderApiClient::AddFile.new(title: 'test', filename: 'test.txt', data: 'bla bla bla', collection_ref: 'a45c556f-a628-41d3-8c29-351f84e63757').call

=> #<MojFileUploaderApiClient::Response:0x007fe4e5c85ce0
 @body={:collection=>"a45c556f-a628-41d3-8c29-351f84e63757", :key=>"7c6aca2c-eb7a-4194-8166-9fd6ac82127b.test.txt"},
 @code=200>
```

#### No previous collection reference (will create a new one):

```ruby
MojFileUploaderApiClient::AddFile.new(title: 'test', filename: 'test.txt', data: 'bla bla bla').call

=> #<MojFileUploaderApiClient::Response:0x007fe4e5b8cc58
 @body={:collection=>"741635f7-488a-49cc-a3f1-9ee38795e28e", :key=>"0543a21d-e884-4076-89be-41cc09b00da1.test.txt"},
 @code=200>
```

### Delete a file

```ruby
MojFileUploaderApiClient::DeleteFile.new(collection_ref: 'a45c556f-a628-41d3-8c29-351f84e63757', filename: 'test1.txt').call
=> #<MojFileUploaderApiClient::Response:0x007fe4e59c8098 @body={:body_parser_error=>"743: unexpected token at ''"}, @code=204>
```

### List files

```ruby
MojFileUploaderApiClient::ListFiles.new(collection_ref: 'a45c556f-a628-41d3-8c29-351f84e63757').call
=> #<MojFileUploaderApiClient::Response:0x007fe4e5ac91e0
 @body=
  {:collection=>"a45c556f-a628-41d3-8c29-351f84e63757",
   :files=>[{:key=>"a45c556f-a628-41d3-8c29-351f84e63757/test1.txt", :title=>"test1.txt", :last_modified=>"2016-11-30T15:30:52.000Z"}]},
 @code=200>
```

## Contributing

Fork, then clone the repo:

```bash
git clone git@github.com:your-username/mojfile-uploader-api-client.git
```

Make sure the tests pass:

```bash
bundle exec rake
```

Make your change. Add specs for your change. Make the specs pass:

```bash
bundle exec rake
```

Push to your fork and [submit a pull request][pr].

[pr]: https://github.com/ministryofjustice/mojfile-uploader-api-client/compare

Some things that will increase the chance that your pull request is
accepted:

* Write specs.
* Make sure you don’t have any mutants (part of total test suite).
* Write a [good commit message][commit].

[commit]: https://github.com/alphagov/styleguides/blob/master/git.md

## License

Released under the [MIT License](http://opensource.org/licenses/MIT).
Copyright (c) 2016 Ministry of Justice.

