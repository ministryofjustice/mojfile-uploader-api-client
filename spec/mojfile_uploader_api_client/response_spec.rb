require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::Response do

  subject { described_class.new(code: code, body: body) }

  describe 'successful responses' do
    let(:code) { 200 }
    let(:body) { {result: 'ok'}.to_json }

    it 'has a body' do
      expect(subject.body).to eq({result: 'ok'})
    end

    context '200 code' do
      let(:code) { 200 }

      it 'has a code' do
        expect(subject.code).to eq(200)
      end

      it 'success true' do
        expect(subject.success?).to be_truthy
      end

      it 'error false' do
        expect(subject.error?).to be_falsey
      end
    end

    context '204 code' do
      let(:code) { 204 }

      it 'has a code' do
        expect(subject.code).to eq(204)
      end

      it 'success true' do
        expect(subject.success?).to be_truthy
      end

      it 'error false' do
        expect(subject.error?).to be_falsey
      end
    end
  end

  describe 'unsuccessful response' do
    let(:code) { 404 }
    let(:body) { 'not found' }

    it 'has a code' do
      expect(subject.code).to eq(404)
    end

    it 'has a body' do
      expect(subject.body).to eq({body_parser_error: "743: unexpected token at 'not found'"})
    end

    it 'success false' do
      expect(subject.success?).to be_falsey
    end

    it 'error true' do
      expect(subject.error?).to be_truthy
    end
  end

  describe 'blank body response' do
    let(:code) { 200 }
    let(:body) { '' }

    it 'has a code' do
      expect(subject.code).to eq(200)
    end

    it 'has blank body' do
      expect(subject.body).to eq('')
    end

    it 'success false' do
      expect(subject.success?).to be_truthy
    end

    it 'error true' do
      expect(subject.error?).to be_falsey
    end
  end

  describe 'no body response' do
    let(:code) { 200 }
    let(:body) { nil }

    it 'has a code' do
      expect(subject.code).to eq(200)
    end

    it 'has nil body' do
      expect(subject.body).to be_nil
    end

    it 'success false' do
      expect(subject.success?).to be_truthy
    end

    it 'error true' do
      expect(subject.error?).to be_falsey
    end
  end
end
