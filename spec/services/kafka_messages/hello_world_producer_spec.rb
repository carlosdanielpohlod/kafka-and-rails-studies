require 'rails_helper'

RSpec.describe KafkaMessages::HelloWorldProducer do
  describe '#call' do
    let(:event) do
      instance_double(
        Events::HelloWorld,
        message: 'Hello, world!'
      )
    end

    context 'when DeliveryBoy.deliver has no error' do
      before do
        allow(DeliveryBoy).to receive(:deliver)
      end

      it 'Calls #deliver with correct params' do
        described_class.new(event:).call

        expect(DeliveryBoy)
          .to have_received(:deliver)
          .with('Hello, world!', { topic: 'hello-world' })
      end

      it 'returns a ServiceResult with success true' do
        result = described_class.new(event:).call

        expect(result.success?).to eq(true)
      end
    end

    context 'when DeliveryBoy.deliver raises an error' do
      before do
        allow(DeliveryBoy)
          .to receive(:deliver)
          .and_raise(StandardError, 'Some error')
      end

      it 'returns a ServiceResult with success false' do
        result = described_class.new(event:).call

        expect(result.success?).to eq(false)
      end

      it 'returns a ServiceResult with error message' do
        result = described_class.new(event:).call

        expect(result.error).to eq('Failed to send message to Kafka: Some error')
      end
    end
  end
end
