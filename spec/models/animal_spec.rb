require 'rails_helper'

RSpec.describe Animal, type: :model do

  let(:animal){ FactoryBot.build(:animal)}

  describe '.valid' do

    it 'should check validity' do
      expect(animal.valid?).to eq true
      animal.shelter = nil
      expect(animal.valid?).to eq false
    end
  end

  describe 'update attributes callback' do
    context 'before save' do
      it 'attributes are not updated yet' do
        expect(animal.pending_adoption).to eq false
        expect(animal.shelter_name).to eq nil
      end
    end

    context 'after dave' do
      it 'attributes are updated ' do
        animal.update(adoption_request: FactoryBot.build(:adoption_request))
        animal.save!
        expect(animal.pending_adoption).to eq true
        expect(animal.shelter_name).to eq animal.shelter.name
        expect(AdoptionRequest.first.animal.id).to eq animal.id
      end
    end
  end
end
