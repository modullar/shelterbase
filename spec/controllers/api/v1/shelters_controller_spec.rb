require 'rails_helper'

RSpec.describe Api::V1::SheltersController, type: :controller do
  let(:client){ FactoryBot.create(:client, password: '123') }
  let(:worker){ FactoryBot.create(:worker, password: '123') }
  let(:shelter_params) {FactoryBot.attributes_for(:shelter) }

  def authorized_header
    token = Knock::AuthToken.new(payload: { sub: client.id }).token
    "Bearer #{token}"
  end

  def unauthorized_header
    token = Knock::AuthToken.new(payload: { sub: worker.id }).token
    "Bearer #{token}"
  end

  describe 'POST #create' do
    context 'unauthorized request' do
      it 'must return 401 unauthorized' do
        request.headers['Authorization'] = unauthorized_header
        post :create, params: {shelter: shelter_params}
        expect(response.status).to eq 401
      end
    end

    context 'authorised requset' do
      it 'must return 201 authorized and create new shelter' do
        request.headers['Authorization'] = authorized_header
        post :create, params: {shelter: shelter_params}
        expect(response.status).to eq 201
        expect(Shelter.count).to eq 1
      end
    end
  end

  describe 'DELETE #delete' do
    before do
      request.headers['Authorization'] = authorized_header
    end

    context 'shelter does not exists' do
      it 'should raise 404 error response' do
        delete :destroy, params: {id: 1}
        expect(response.status).to eq 404
      end
    end

    context 'shelter exists' do
      before do
        post :create, params: {shelter: shelter_params}
      end

      it 'should return 202 & delete the shelter' do
        expect(Shelter.count).to eq 1
        delete :destroy, params: {id: Shelter.first.id}
        expect(response.status).to eq 202
        expect(Shelter.count).to eq 0
      end
    end


  end





end
