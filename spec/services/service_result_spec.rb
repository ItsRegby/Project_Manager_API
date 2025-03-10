RSpec.describe ServiceResult do
  describe ".success" do
    it "returns a successful result with data" do
      data = { key: "value" }
      result = described_class.success(data)

      expect(result.success?).to be true
      expect(result.data).to eq(data)
      expect(result.error).to be_nil
    end
  end

  describe ".failure" do
    it "returns a failed result with an error" do
      error = "Something went wrong"
      result = described_class.failure(error)

      expect(result.success?).to be false
      expect(result.data).to be_nil
      expect(result.error).to eq(error)
    end
  end

  describe "#success?" do
    it "returns true for a successful result" do
      result = described_class.new(true)
      expect(result.success?).to be true
    end

    it "returns false for a failed result" do
      result = described_class.new(false)
      expect(result.success?).to be false
    end
  end

  describe "#data" do
    it "returns the data for a successful result" do
      data = { key: "value" }
      result = described_class.new(true, data)
      expect(result.data).to eq(data)
    end

    it "returns nil for a failed result" do
      result = described_class.new(false)
      expect(result.data).to be_nil
    end
  end

  describe "#error" do
    it "returns the error for a failed result" do
      error = "Something went wrong"
      result = described_class.new(false, nil, error)
      expect(result.error).to eq(error)
    end

    it "returns nil for a successful result" do
      result = described_class.new(true)
      expect(result.error).to be_nil
    end
  end
end
