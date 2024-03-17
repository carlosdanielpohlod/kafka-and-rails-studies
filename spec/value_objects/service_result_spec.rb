require 'rails_helper'

RSpec.describe ServiceResult do
  describe '#initialize' do
    it 'instantiates a ServiceResult object with success and error attributes' do
      service_result = ServiceResult.new(true, 'Some error')

      expect(service_result.success).to eq(true)
      expect(service_result.error).to eq('Some error')
    end
  end

  describe '#success?' do
    it 'returns the value of success attribute' do
      service_result = ServiceResult.new(true)

      expect(service_result.success?).to eq(true)
    end
  end
end
