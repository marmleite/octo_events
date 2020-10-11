require 'rails_helper'

RSpec.describe Event, type: :model do

  subject {
    described_class.new(
      name: 'Issue',
      guid: 'guid',
      payload: '{}'
    )
  }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a guid' do
    subject.guid = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a payload' do
    subject.payload = nil
    expect(subject).to_not be_valid
  end
end
