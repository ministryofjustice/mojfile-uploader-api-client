require 'spec_helper'

RSpec.describe MojFileUploaderApiClient do
  subject(:client) { described_class }

  let(:response) { instance_double(MojFileUploaderApiClient::Response, success?: success, code: code) }
  let(:client_object) { instance_double(client_class) }
  let(:body) { double('body') }

  before do
    expect(client_class).to receive(:new).with(params).and_return(client_object)
    expect(client_object).to receive(:call).and_return(response)
  end

  describe '.add_file' do
    let(:client_class) { MojFileUploaderApiClient::AddFile }
    let(:params) {{
      collection_ref: '123',
      title: 'title',
      filename: 'filename',
      data: 'data'
    }}

    context 'when the response is successful' do
      let(:success) { true }
      let(:code) { 200 }

      it 'returns the body' do
        expect(response).to receive(:body).and_return(body)
        expect(client.add_file(params)).to eq(body)
      end
    end

    context 'when the response is unsuccessful (virus infected file)' do
      let(:success) { false }
      let(:code) { 400 }

      it 'raises InfectedFileError' do
        expect { client.add_file(params) }.to raise_error(MojFileUploaderApiClient::InfectedFileError)
      end
    end

    context 'when the response is unsuccessful (other error)' do
      let(:success) { false }
      let(:code) { 402 }

      it 'raises RequestError' do
        expect { client.add_file(params) }.to raise_error(MojFileUploaderApiClient::RequestError)
      end
    end
  end

  describe '.delete_file' do
    let(:client_class) { MojFileUploaderApiClient::DeleteFile }
    let(:params) {{
      collection_ref: '123',
      filename: 'filename',
    }}

    context 'when the response is successful' do
      let(:success) { true }
      let(:code) { 200 }

      it 'returns the body' do
        expect(response).to receive(:body).and_return(body)
        expect(client.delete_file(params)).to eq(body)
      end
    end

    context 'when the response is unsuccessful' do
      let(:success) { false }
      let(:code) { 402 }

      it 'raises RequestError' do
        expect { client.delete_file(params) }.to raise_error(MojFileUploaderApiClient::RequestError)
      end
    end
  end

  describe '.list_files' do
    let(:client_class) { MojFileUploaderApiClient::ListFiles }
    let(:params) {{
      collection_ref: '123'
    }}

    context 'when the response is successful' do
      let(:success) { true }
      let(:code) { 200 }

      it 'returns the body' do
        expect(response).to receive(:body).and_return(body)
        expect(client.list_files(params)).to eq(body)
      end
    end

    context 'when the response is unsuccessful' do
      let(:success) { false }
      let(:code) { 402 }

      it 'raises RequestError' do
        expect { client.list_files(params) }.to raise_error(MojFileUploaderApiClient::RequestError)
      end
    end
  end
end
