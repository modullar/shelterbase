require 'rails_helper'

RSpec.describe Api::V1::WorkersController, type: :controller do

  let(:client){ FactoryBot.create(:client, password: '123') }
  let(:user){ FactoryBot.create(:user, password: '123') }
  let(:shelter){ FactoryBot.create(:shelter)}
  let(:worker_params) {FactoryBot.attributes_for(:worker).merge({shelter_id: shelter.id}) }

  def authorized_header
    token = Knock::AuthToken.new(payload: { sub: client.id }).token
    "Bearer #{token}"
  end

  def unauthorized_header
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    "Bearer #{token}"
  end

  describe 'POST #create' do
    context 'unauthorized request' do
      it 'must return 401 unauthorized' do
        request.headers['Authorization'] = unauthorized_header
        post :create, params: {worker: worker_params}
        expect(response.status).to eq 401
      end
    end

    context 'authorised requset' do
      it 'must return 201 authorized and create new worker' do
        request.headers['Authorization'] = authorized_header
        post :create, params: {worker: worker_params}
        expect(response.status).to eq 201
        expect(Worker.count).to eq 1
      end
    end
  end

  describe 'DELETE #delete' do
    before do
      request.headers['Authorization'] = authorized_header
    end

    context 'worker does not exists' do
      it 'should raise 404 error response' do
        delete :destroy, params: {id: 1}
        expect(response.status).to eq 404
      end
    end

    context 'worker exists' do
      before do
        post :create, params: {worker: worker_params}
      end

      it 'should return 200 & delete the worker' do
        expect(Worker.count).to eq 1
        delete :destroy, params: {id: Worker.first.id}
        expect(response.status).to eq 204
        expect(Worker.count).to eq 0
      end
    end
  end
end
