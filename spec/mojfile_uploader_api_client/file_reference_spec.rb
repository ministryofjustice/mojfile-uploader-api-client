require 'spec_helper'

RSpec.describe MojFileUploaderApiClient::FileReference do

  subject { described_class.new(key: key, title: title, last_modified: last_modified) }

  let(:key) { 'key' }
  let(:title) { 'title' }
  let(:last_modified) { '2016-11-30T12:54:23.000Z' }

  describe '.new' do
    it 'should initialize a new file reference' do
      expect(subject).not_to be_nil
    end

    it 'has a key' do
      expect(subject.key).to eq(key)
    end

    it 'has a title' do
      expect(subject.title).to eq(title)
    end

    it 'has a last_modified' do
      expect(subject.last_modified).to eq(last_modified)
    end
  end
end
