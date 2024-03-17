require 'rails_helper'

RSpec.describe Api::V1::KafkaController, type: :controller do
  describe 'POST #hello_world' do
    context 'when HelloWorldProducer has no error' do
      before do
        allow(KafkaMessages::HelloWorldProducer)
          .to receive(:new)
          .and_return(
            instance_double(
              KafkaMessages::HelloWorldProducer,
              call: ServiceResult.new(success: true)
            )
          )
      end

      it 'returns status code 200' do
        post :hello_world, params: { message: 'Hello, world!' }

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
