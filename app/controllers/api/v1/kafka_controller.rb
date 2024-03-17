class Api::V1::KafkaController < ApplicationController
  def hello_world
    event = Events::HelloWorld.new(message: params[:message])

    result = KafkaMessages::HelloWorldProducer.new(event:).call

    if result.success?
      head(:ok)
    else
      render json: { error: result.error }, status: :bad_request
    end
  end
end
