require 'swagger_helper'
require 'rails_helper'

describe 'Shelterbase API::V1' do

  describe '.client portal' do
    let(:client){ FactoryBot.create(:client, password: '123') }
    let(:shelter){ FactoryBot.create(:shelter)}
    let(:token){ Knock::AuthToken.new(payload: { sub: client.id }).token }
    let(:worker_attributres) { FactoryBot.attributes_for(:worker).merge({shelter_id: shelter.id}) }
    let(:shelter_attributes){ FactoryBot.attributes_for(:shelter) }
    let(:Authorization) {"Bearer #{token}"}

    path '/api/v1/shelters' do
      post 'create an animal shelter' do
        consumes 'application/json'
        parameter name: :shelter, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string },
            location: { type: :string },
          },
          required: [ 'name' ]
        }

        response '201', 'shelter is created' do
          schema type: :object,
            properties: {
              msg: { type: :string },
            },
            required: [ 'msg']
          let(:shelter){ {shelter: shelter_attributes} }
          run_test!
        end
      end
    end

    path '/api/v1/shelters/{id}' do
      delete 'destroy a shelter' do
        produces 'application/json'
        parameter name: :id, in: :path, type: :number

        response '202', 'shelter is deleted' do
          schema type: :object,
            properties: {
              msg: { type: :string },
            },
            required: [ 'msg']
          let(:id){ FactoryBot.create(:shelter).id }
          run_test!
        end
      end

    end




    path '/api/v1/workers' do

      post 'Create a worker' do
        consumes 'application/json'
        parameter name: :worker, in: :body, schema: {
          type: :object,
          properties: {
            worker: {type: :object,
                     properties: {
                       email: { type: :string },
                       username: { type: :string },
                       password: {type: :string, format: :password, options: {hidden: true}},
                       shelter_id: {type: :number}
                       }},
                       required: [ 'email', 'username', 'password', 'shelter_id' ]
          },
          required: [ 'worker' ]
        }

        response '201', 'worker is created' do
          schema type: :object,
            properties: {
              msg: { type: :string },
            },
            required: [ 'msg']
          let(:worker){ {worker: worker_attributres} }
          run_test!
        end

        response '400', 'bad request' do
          let(:worker) { { falsy_hash: 'foo' } }
          run_test!
        end
      end
    end

    path '/api/v1/workers/{id}' do

      get 'retrieve a worker' do
        produces 'application/json'
        parameter name: :id, in: :path, type: :number

        response '200', 'worker is found' do
          schema type: :object,
            properties: {
              data: {
                type: :object,
                properties: {
                  username: { type: :string },
                  email: {type: :string},
                  shelter_id: {type: :number}
                }
              }
            },
            required: [ 'data']

          let(:id){ FactoryBot.create(:worker).id }
          run_test!
        end
      end


      delete 'destroy a worker' do
        produces 'application/json'
        parameter name: :id, in: :path, type: :number

        response '202', 'worker is removed' do
          schema type: :object,
            properties: {
              msg: { type: :string },
            },
            required: [ 'msg']
          let(:id){ FactoryBot.create(:worker).id }
          run_test!
        end
      end
    end
  end

end
