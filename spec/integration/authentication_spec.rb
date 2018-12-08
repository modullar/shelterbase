require 'swagger_helper'
require 'rails_helper'

  describe 'Authentication' do
    let(:Authorization) {}
    let(:user){FactoryBot.create(:user, password: '123')}

    path '/user_token' do
      post 'Create a user token' do
        consumes 'application/json'
        parameter name: :auth, in: :body, schema: {
          type: :object,
          properties: {
            auth: {type: :object,
                  properties: {
                    email: { type: :string },
                    password: { type: :string, format: :password },
                    }},
                    required: [ 'email', 'password']
          },
          required: [ 'auth']
        }

        response '201', 'token is created' do
          schema type: :object,
                 properties: {
                   jwt: { type: :string },
                 },
                 required: [ 'jwt']

          let(:auth){{ auth: {email: user.email,password: '123'}}}
          run_test!
        end
      end
    end
  end
