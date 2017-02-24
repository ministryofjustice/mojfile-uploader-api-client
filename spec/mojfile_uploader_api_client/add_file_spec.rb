require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::AddFile do
  let(:client) { RestClient::Request }
  let(:response) { instance_double('Response', code: 200, body: '{}') }
  let(:file_arguments) { {folder: 'subfolder', filename: 'test.txt', data: 'bla bla bla'} }

  subject { described_class.new(file_arguments) }

  before(:each) do
    allow(client).to receive(:execute).and_return(response)
  end

  context 'endpoint' do
    context 'when no collection_ref provided' do
      let(:expected_endpoint) { '/new' }

      it 'should build the endpoint without a collection_ref' do
        expect(subject.endpoint).to eq(expected_endpoint)
      end
    end

    context 'when an existing collection_ref is provided' do
      let(:file_arguments) { {folder: 'subfolder', filename: 'test.txt', data: 'bla bla bla', collection_ref: 'abc-123-xxx'} }
      let(:expected_endpoint) { 'abc-123-xxx/new' }

      it 'should build the endpoint without a collection_ref' do
        expect(subject.endpoint).to eq(expected_endpoint)
      end
    end
  end

  context 'URL' do
    context 'when no collection_ref provided' do
      let(:expected_url) { 'http://example.com/new' }

      it 'should build the full URL using base_url and endpoint' do
        expect(client).to receive(:execute).with(hash_including(url: expected_url))
        subject.call
      end
    end

    context 'when an existing collection_ref is provided' do
      let(:file_arguments) { {folder: 'subfolder', filename: 'test.txt', data: 'bla bla bla', collection_ref: 'abc-123-xxx'} }
      let(:expected_url) { 'http://example.com/abc-123-xxx/new' }

      it 'should build the full URL using base_url and endpoint' do
        expect(client).to receive(:execute).with(hash_including(url: expected_url))
        subject.call
      end
    end
  end

  context 'method' do
    let(:expected_method) { :post }

    it 'should use the specified method' do
      expect(client).to receive(:execute).with(hash_including(method: expected_method))
      subject.call
    end
  end

  context 'payload' do
    context 'when a folder is given' do
      let(:file_arguments) { {folder: 'subfolder', filename: 'test.txt', data: 'bla bla bla', collection_ref: 'abc-123-xxx'} }
      let(:expected_payload) { "{\"file_filename\":\"test.txt\",\"file_data\":\"bla bla bla\",\"folder\":\"subfolder\"}" }

      it 'should send the specified payload' do
        expect(client).to receive(:execute).with(hash_including(:method, :url, :headers, :verify_ssl, :open_timeout, :read_timeout,
                                                                payload: expected_payload))
        subject.call
      end
    end

    context 'when no folder is given' do
      let(:file_arguments) { {filename: 'test.txt', data: 'bla bla bla', collection_ref: 'abc-123-xxx'} }
      let(:expected_payload) { "{\"file_filename\":\"test.txt\",\"file_data\":\"bla bla bla\"}" }

      it 'should send the specified payload' do
        expect(client).to receive(:execute).with(hash_including(:method, :url, :headers, :verify_ssl, :open_timeout, :read_timeout,
                                                                payload: expected_payload))
        subject.call
      end
    end
  end
end
