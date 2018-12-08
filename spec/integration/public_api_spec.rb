require 'swagger_helper'
require 'rails_helper'

describe 'Shelterbase API::V1' do

  describe 'animal lovers portal' do
    let(:Authorization) {}
    path '/api/v1/animals' do

      get 'get a list of animals' do
        produces 'application/json'
        parameter name: :shelter_name, in: :query, type: :string
        parameter name: :pending_adoption, in: :query, type: :boolean

        response '200', 'retreive animals' do
          schema type: :object,
            properties: {
              animals: {type: :array}
            },
            required: ['animals']
          let(:shelter_name){}
          let(:pending_adoption){}
          run_test!
        end
      end
    end

    path '/api/v1/animals/{id}' do

      get 'get an animal detail' do
        produces 'application/json'
        parameter name: :id, in: :path, type: :number

        response '200', 'retreive animals' do
          schema type: :object,
            properties: {
              id: {type: :number},
              race: {type: :string},
              shelter_id: {type: :number},
              adoption_request_id: {type: {"anyOf": [:null, :number] }},
              pending_adoption: {type: :bool},
              shelter_name: {type: :string},
              medical_condition: {type: :string},
            },
            required: ['medical_condition']
          let(:id){ FactoryBot.create(:animal).id }
          run_test!
        end
      end
    end

    path '/api/v1/adoption_requests' do

      post 'create a new adoption request' do
        consumes 'application/json'
        parameter name: :adoption_request, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            email: { type: :string },
            telephone_number: { type: :string },
            animal_id: {type: :number}
          },
          required: [ 'email', 'name', 'telephone_number', 'animal_id']
        }

        response '201', 'token is created' do
          schema type: :object,
                 properties: {
                   msg: { type: :string },
                 },
                 required: [ 'msg']

          let(:animal){FactoryBot.create(:animal)}
          let(:adoption_request){ FactoryBot.attributes_for(:adoption_request).merge({animal_id: animal.id}) }
          run_test!
        end
      end
    end
  end
end
