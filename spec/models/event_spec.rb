require 'rails_helper'

RSpec.describe Event, type: :model do

  subject {
    described_class.new(
      name: 'Issue',
      guid: 'guid',
      payload: {
        sender: ''
      }
    )
  }

  context 'with valid attributes' do
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'without a name' do
    it 'is not valid' do
      subject.name = nil

      expect(subject).to_not be_valid
    end
  end

  context 'without a guid' do
    it 'is not valid' do
      subject.guid = nil

      expect(subject).to_not be_valid
    end
  end

  context 'without a payload' do
    it 'is not valid' do
      subject.payload = nil

      expect(subject).to_not be_valid
    end
  end

  describe 'with paylaod' do
    context 'without render' do
      it 'is not valid' do
        subject.payload.delete('sender')

        expect(subject).to_not be_valid
      end
    end
  end
end
