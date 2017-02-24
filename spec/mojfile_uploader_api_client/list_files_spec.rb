require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::ListFiles do
  let(:client) { RestClient::Request }
  let(:response) { instance_double('Response', code: 200, body: '{}') }
  let(:file_arguments) { {collection_ref: 'abc-123-xxx'} }

  subject { described_class.new(file_arguments) }

  before(:each) do
    allow(client).to receive(:execute).and_return(response)
  end

  context 'endpoint' do
    context 'without a folder' do
      let(:file_arguments) { {collection_ref: 'abc-123-xxx'} }
      let(:expected_endpoint) { 'abc-123-xxx' }

      it 'should build the endpoint using the collection_ref' do
        expect(subject.endpoint).to eq(expected_endpoint)
      end
    end

    context 'with a folder' do
      let(:file_arguments) { {folder: 'subfolder', collection_ref: 'abc-123-xxx'} }
      let(:expected_endpoint) { 'abc-123-xxx/subfolder' }

      it 'should build the endpoint using the collection_ref' do
        expect(subject.endpoint).to eq(expected_endpoint)
      end
    end
  end

  context 'URL' do
    context 'without a folder' do
      let(:file_arguments) { {collection_ref: 'abc-123-xxx'} }
      let(:expected_url) { 'http://example.com/abc-123-xxx' }

      it 'should build the full URL using base_url and endpoint' do
        expect(client).to receive(:execute).with(hash_including(url: expected_url))
        subject.call
      end
    end

    context 'with a folder' do
      let(:file_arguments) { {folder: 'subfolder', collection_ref: 'abc-123-xxx'} }
      let(:expected_url) { 'http://example.com/abc-123-xxx/subfolder' }

      it 'should build the full URL using base_url and endpoint' do
        expect(client).to receive(:execute).with(hash_including(url: expected_url))
        subject.call
      end
    end
  end

  context 'method' do
    let(:expected_method) { :get }

    it 'should use the specified method' do
      expect(client).to receive(:execute).with(hash_including(method: expected_method))
      subject.call
    end
  end
end
