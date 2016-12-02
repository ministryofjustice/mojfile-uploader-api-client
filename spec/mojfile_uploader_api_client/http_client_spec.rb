require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::HttpClient do

  subject { described_class.new }

  let(:client) { RestClient::Request }
  let(:response) { instance_double('Response', code: 200, body: '{}') }

  describe 'default options' do
    it 'should have a default set of client options' do
      expect(subject.options).to eq({headers: {"Content-Type" => "application/json", "Accept" => "application/json"},
                                     verify_ssl: false,
                                     open_timeout: 5,
                                     read_timeout: 15})
    end
  end

  describe 'overriding default options' do
    before(:each) do
      MojFileUploaderApiClient::HttpClient.configure do |config|
        config.options = {open_timeout: 100, read_timeout: 500, verify_ssl: true}
      end
    end

    it 'should be able to override any of the default client options' do
      expect(subject.options).to eq({headers: {"Content-Type" => "application/json", "Accept" => "application/json"},
                                     verify_ssl: true,
                                     open_timeout: 100,
                                     read_timeout: 500})
    end
  end

  describe '#payload?' do
    context 'payload is defined' do
      it 'should return true' do
        expect(subject).to receive(:payload).and_return({})
        expect(subject.payload?).to be_truthy
      end
    end

    context 'payload is not defined' do
      it 'should return false' do
        expect(subject).to receive(:payload).and_return(nil)
        expect(subject.payload?).to be_falsey
      end
    end
  end

  describe 'endpoint or verb methods are not implemented' do
    context 'no endpoint defined' do
      before(:each) do
        allow(subject).to receive(:verb).and_return(:get)
      end

      it 'should raise an exception' do
        expect { subject.call }.to raise_error('not implemented')
      end
    end

    context 'no verb defined' do
      before(:each) do
        allow(subject).to receive(:endpoint).and_return('/test')
      end

      it 'should raise an exception' do
        expect { subject.call }.to raise_error('not implemented')
      end
    end
  end

  describe 'response' do
    before(:each) do
      allow(subject).to receive(:verb).and_return(:get)
      allow(subject).to receive(:endpoint).and_return('/test')
      allow(client).to receive(:execute).and_return(response)
    end

    # URL is being tested in subclass specs but Mutant is a bit picky and want it to be covered also here.
    describe '#url' do
      it 'should build the full URL using base_url and endpoint' do
        expect(client).to receive(:execute).with(hash_including(url: 'http://example.com/test'))
        subject.call
      end
    end

    # Payload is being tested in add_file_spec but Mutant is a bit picky and want it to be covered also here.
    context 'payload' do
      context 'payload not defined' do
        it 'should not merge any payload by default' do
          expect(subject).to receive(:payload?).once.and_return(false)
          expect(client).to receive(:execute).with(hash_including(:method, :url, :headers, :verify_ssl, :open_timeout, :read_timeout))
          subject.call
        end
      end

      context 'payload defined' do
        before(:each) do
          allow(subject).to receive(:payload).and_return({status: 'ok'})
        end
        it 'should merge the payload if defined' do
          expect(subject).to receive(:payload?).once.and_return(true)
          expect(client).to receive(:execute).with(hash_including(:method, :url, :headers, :verify_ssl, :open_timeout, :read_timeout,
                                                                  payload: "{\"status\":\"ok\"}"))
          subject.call
        end
      end
    end

    context 'execute the request and get the response' do
      it 'should return a response object' do
        expect(subject).to receive(:response).once.and_call_original
        response = subject.call
        expect(response).to be_a(MojFileUploaderApiClient::Response)
      end

      it 'should assign a response object' do
        subject.call
        expect(subject.response).to be_a(MojFileUploaderApiClient::Response)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(200)
        expect(response.body).to eq({})
      end
    end

    context 'restclient exception' do
      let(:exception) { RestClient::Exception.new(nil, 500) }

      before(:each) do
        allow(client).to receive(:execute).and_raise(exception)
      end

      it 'success? should be false' do
        subject.call
        expect(subject.response.success?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(500)
        expect(response.body).to eq(nil)
      end
    end

    context 'request unsuccessful with body' do
      let(:response) { instance_double('Response', code: 404, body: 'boom') }

      it 'success? should be false' do
        subject.call
        expect(subject.response.success?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(404)
        expect(response.body).to eq({body_parser_error: "743: unexpected token at 'boom'"})
      end
    end

    context 'request unsuccessful with body blank' do
      let(:response) { instance_double('Response', code: 404, body: '') }

      it 'success? should be false' do
        subject.call
        expect(subject.response.success?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(404)
        expect(response.body).to eq('')
      end
    end

    context 'request unsuccessful without body' do
      let(:response) { instance_double('Response', code: 404, body: nil) }

      it 'success? should be false' do
        subject.call
        expect(subject.response.success?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(404)
        expect(response.body).to eq(nil)
      end
    end
  end
end
