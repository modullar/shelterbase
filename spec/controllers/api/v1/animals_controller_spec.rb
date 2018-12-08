require 'rails_helper'

RSpec.describe Api::V1::AnimalsController, type: :controller do

  describe 'GET #index' do

    let!(:shelter){ FactoryBot.create(:shelter) }
    let!(:different_shelter){ FactoryBot.create(:shelter) }

    let!(:animal_with_pending_adoption){ FactoryBot.create(:animal, shelter: shelter) }
    let!(:animal_without_pending_adoption){ FactoryBot.create(:animal, shelter: shelter) }
    let!(:animal_with_different_shelter) { FactoryBot.create(:animal, shelter: different_shelter) }

    let!(:adoption_request){ FactoryBot.create(:adoption_request, animal: animal_with_pending_adoption) }


    context 'no filter is in the request' do
      it 'should returns all available animals in the database' do
        get :index
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["animals"].size).to eq 3
      end
    end

    context 'shelter name filter' do
      it 'should returns all available animals with the specific name' do
        get :index, params: {shelter_name: shelter.name}
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["animals"].size).to eq 2
      end
    end

    context 'pending adoption filter' do
      it 'should returns all available animals with the specific adoption filter' do
        get :index, params:  {"pending_adoption": false}
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["animals"].size).to eq 2
      end
    end

    context 'pending adoption and shelter name filter' do
      it 'should returns all available animals with the specific name and adoption filter' do
        get :index, params: {"pending_adoption": true, "shelter_name": shelter.name}
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["animals"].size).to eq 1
      end
    end

  end

  describe 'GET #show' do
    context 'animal does not exists' do
      it 'should raise 404 error response' do
        get :show, params: {id: 1}
        expect(response.status).to eq 404
      end
    end

    context 'animal exists' do
      before do
        FactoryBot.create(:animal)
      end

      it 'should return 200 & delete the shelter' do
        get :show, params: {id: Animal.first.id}
        expect(response.status).to eq 200
      end
    end

  end


end
