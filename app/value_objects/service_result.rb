class ServiceResult
  attr_accessor :success, :result, :error

  alias success? success

  def initialize(success, error = nil)
    @success = success
    @error = error
  end
end
