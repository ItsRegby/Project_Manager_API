class ServiceResult
  attr_reader :data, :error

  def initialize(success, data = nil, error = nil)
    @success = success
    @data = data
    @error = error
  end

  def success?
    @success
  end

  def self.success(data = {})
    new(true, data, nil)
  end

  def self.failure(error)
    new(false, nil, error)
  end
end
