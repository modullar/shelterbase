require "rails_helper"

RSpec.describe AnimalSerializer, type: :model do
  let(:animal){FactoryBot.create(:animal)}
  let(:serializer) { described_class.new(animal) }
  let(:subject){ JSON.parse(serializer.serialized_json) }

  describe 'attribute' do
    it 'should return the right attribute' do
      expect(subject["data"]["attributes"]["temp_name"]).to eq animal.temp_name
      expect(subject["data"]["attributes"]["race"]).to eq animal.race
      expect(subject["data"]["attributes"]["medical_condition"]).to eq animal.medical_condition
      expect(subject["data"]["attributes"]["pending_adoption"]).to eq animal.pending_adoption
      expect(subject["data"]["attributes"]["shelter_name"]).to eq animal.shelter.name
    end
  end
end
