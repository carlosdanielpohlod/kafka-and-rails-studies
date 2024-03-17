require 'rails_helper'

RSpec.describe 'Api::V1::Kafka', type: :request do
  describe 'POST /api/v1/kafka/hello_world' do
    it 'sends a message to Kafka' do
      post '/api/v1/kafka/hello_world', params: { message: 'Hello, world!' }

      expect(response).to have_http_status(:ok)
    end
  end
end
