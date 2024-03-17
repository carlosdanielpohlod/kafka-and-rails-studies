require 'rails_helper'

RSpec.describe 'Api::V1::Kafka', type: :request do
  describe 'POST /api/v1/kafka/hello_world' do
    context 'when DeliveryBoy.deliver has no error' do
      setup do
        DeliveryBoy.test_mode!
      end

      after do
        DeliveryBoy.testing.clear
      end

      it 'returns status code 200' do
        post '/api/v1/kafka/hello_world', params: { message: 'Hello, world!' }

        expect(response).to have_http_status(:ok)
      end

      it 'sends a message to Kafka on correct topic' do
        post '/api/v1/kafka/hello_world', params: { message: 'Hello, world!' }

        message = DeliveryBoy.testing.messages_for('hello-world').first

        expect(message.value).to eq('Hello, world!')
        expect(message.topic).to eq('hello-world')
      end
    end

    context 'when DeliveryBoy.deliver raises an error' do
      before do
        allow(DeliveryBoy)
          .to receive(:deliver)
          .and_raise(StandardError, 'Some error')
      end

      it 'returns status code 400' do
        post '/api/v1/kafka/hello_world', params: { message: 'Hello, world!' }

        expect(response).to have_http_status(:bad_request)
      end

      it 'returns an error message' do
        post '/api/v1/kafka/hello_world', params: { message: 'Hello, world!' }

        expect(response.body).to eq({ error: 'Failed to send message to Kafka: Some error' }.to_json)
      end
    end
  end
end
