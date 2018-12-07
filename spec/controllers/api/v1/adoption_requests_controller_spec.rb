require 'rails_helper'

RSpec.describe Api::V1::AdoptionRequestsController, type: :controller do




  describe 'POST #create' do

    let(:animal) { FactoryBot.build(:animal) }
    let(:adoption_request_params) {FactoryBot.attributes_for(:adoption_request).merge({animal_id: animal.id}) }


    context 'unauthorized creation' do
      before do
        animal.adoption_request = FactoryBot.create(:adoption_request)
        animal.save!
      end
      it 'should return forbidden action status' do
        post :create, params: {adoption_request: adoption_request_params}
        expect(response.status).to eq 403
      end
    end

    context 'invalid input' do
      it 'should return bad request' do
        animal.save!
        adoption_request_params.except!(:name)
        post :create, params: {adoption_request: adoption_request_params}
        expect(response.status).to eq 400
      end
    end

    context ' valid input ' do
      it 'should create the record and return 201 status' do
        animal.save!
        post :create, params: {adoption_request: adoption_request_params}
        expect(response.status).to eq 201
        expect(AdoptionRequest.count).to eq 1
      end
    end
  end
end
