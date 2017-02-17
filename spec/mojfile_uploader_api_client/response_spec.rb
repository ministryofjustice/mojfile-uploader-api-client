require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::Response do
  subject { described_class.new(code: code, body: body) }

  let(:body) { nil }
  let(:code) { nil }

  describe '#body' do
    describe 'when the response body is parsable' do
      let(:body) { {result: 'ok'}.to_json }

      it { is_expected.to have_attributes(body: {result: 'ok'}) }
    end

    describe 'when the response body is nil' do
      let(:body) { nil }

      it { is_expected.to have_attributes(body: nil) }
    end

    describe 'when the response body is empty' do
      let(:body) { '' }

      it { is_expected.to have_attributes(body: nil) }
    end

    describe 'when the response body is unparsable' do
      let(:body) { 'sadifuygwi3P982(*#Q$&(*' }

      it 'raises an error' do
        expect { subject.body }.to raise_error(MojFileUploaderApiClient::Response::UnparsableResponseError)
      end
    end
  end

  describe '#code' do
    describe 'when the response is a 200' do
      let(:code) { 200 }

      it { is_expected.to have_attributes(code: 200) }
      it { is_expected.to be_success }
      it { is_expected.to_not be_error }
    end

    describe 'when the response is a 204' do
      let(:code) { 204 }

      it { is_expected.to have_attributes(code: 204) }
      it { is_expected.to be_success }
      it { is_expected.to_not be_error }
    end

    describe 'when the response is an error code' do
      let(:code) { 404 }

      it { is_expected.to have_attributes(code: 404) }
      it { is_expected.to_not be_success }
      it { is_expected.to be_error }
    end
  end
end
