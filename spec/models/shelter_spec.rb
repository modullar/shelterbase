require 'rails_helper'

RSpec.describe Shelter, type: :model do
  let(:shelter){ FactoryBot.build(:shelter) }

  describe '.valid' do
    it 'should return the validity of the object' do
      expect(shelter.valid?).to be true
      shelter.name = nil
      expect(shelter.valid?).to be false
    end
  end
end
