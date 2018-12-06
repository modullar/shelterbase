require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_user){ FactoryBot.create(:user) }
  let(:invalid_user) { FactoryBot.build(:user, email: valid_user.email) }

  describe '.valid' do
    it 'should validate users according to rules' do
      expect(invalid_user.valid?).to eq false
    end
  end

  describe '.is_role_name?' do
    let(:worker){ FactoryBot.build(:worker) }
    let(:client){ FactoryBot.build(:client) }

    it 'should return the right role for user' do
      expect(worker.is_worker?).to be true
      expect(client.is_client?).to be true
      expect(worker.is_client?).to be false
      expect(client.is_admin?).to be false
    end
  end
end
