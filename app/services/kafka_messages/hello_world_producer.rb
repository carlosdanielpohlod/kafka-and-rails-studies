class KafkaMessages::HelloWorldProducer
  TOPIC_NAME = 'hello-world'

  def initialize(event:)
    @event = event
    @result = ServiceResult.new(true)
  end

  def call
    DeliveryBoy.deliver(
      event.message,
      topic: TOPIC_NAME
    )

    result
  rescue StandardError => e
    result.success = false
    # This kind of message is not suitable for production, the ideal scenario is sending the error to a monitoring tool
    result.error = "Failed to send message to Kafka: #{e.message}"
    result
  end

  private

  attr_reader :event, :result
end
