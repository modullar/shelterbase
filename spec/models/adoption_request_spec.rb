require 'rails_helper'

RSpec.describe AdoptionRequest, type: :model do

  let(:adoption_request){ FactoryBot.build(:adoption_request)}

  describe '.valid' do

    it 'should check validity' do
      expect(adoption_request.valid?).to eq true
      adoption_request.animal = nil
      expect(adoption_request.valid?).to eq false
    end

    it 'should update the corresponding animal with the adoption_request' do
      adoption_request.save!
      expect(Animal.first.adoption_request).to eq adoption_request
      expect(Animal.first.pending_adoption).to eq true
    end
  end


end
