require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::Status do
  let(:client) { RestClient::Request }
  let(:response) { instance_double('Response', code: 200, body: '{}') }

  subject { described_class.new }

  before(:each) do
    allow(client).to receive(:execute).and_return(response)
  end

  context 'endpoint' do
    let(:expected_endpoint) { 'status' }

    it 'should return the endpoint' do
      expect(subject.endpoint).to eq(expected_endpoint)
    end
  end

  context 'URL' do
    let(:expected_url) { 'http://example.com/status' }

    it 'should build the full URL using base_url and endpoint' do
      expect(client).to receive(:execute).with(hash_including(url: expected_url))
      subject.call
    end
  end

  context 'method' do
    let(:expected_method) { :get }

    it 'should use the specified method' do
      expect(client).to receive(:execute).with(hash_including(method: expected_method))
      subject.call
    end
  end

  context 'payload' do
    it 'should not send any payload' do
      expect(client).to receive(:execute).with(hash_not_including(:payload))
      subject.call
    end
  end

  describe '#available?' do
    context 'for a successful response with body' do
      let(:response) { instance_double('Response', code: 200, body: "{\"status\":\"OK\"}") }

      it 'should be true' do
        subject.call
        expect(subject.available?).to eq(true)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(200)
        expect(response.body).to eq({status: 'OK'})
      end
    end

    context 'for a successful response without body' do
      let(:response) { instance_double('Response', code: 200, body: nil) }

      it 'should be false' do
        subject.call
        expect(subject.available?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(200)
        expect(response.body).to eq(nil)
      end
    end

    context 'for an unsuccessful response with body' do
      let(:response) { instance_double('Response', code: 500, body: 'boom') }

      it 'should be false' do
        subject.call
        expect(subject.available?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(500)
        expect(response.body).to eq({body_parser_error: "743: unexpected token at 'boom'"})
      end
    end

    context 'for an unsuccessful response without body' do
      let(:response) { instance_double('Response', code: 500, body: nil) }

      it 'should be false' do
        subject.call
        expect(subject.available?).to eq(false)
      end

      it 'should have a code and a body' do
        subject.call
        response = subject.response

        expect(response.code).to eq(500)
        expect(response.body).to eq(nil)
      end
    end
  end
end
