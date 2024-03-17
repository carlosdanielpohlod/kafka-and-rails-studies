require 'rails_helper'

RSpec.describe Events::HelloWorld, type: :model do
  it { is_expected.to respond_to(:message) }
end
