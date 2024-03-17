class Api::V1::KafkaController < ApplicationController
  def hello_world
    head(:ok)
  end
end
