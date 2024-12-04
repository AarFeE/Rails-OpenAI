require 'rails_helper'

RSpec.describe Form, type: :model do
  # Test validations
  describe "validations" do
    it "is valid with valid attributes" do
      form = Form.new(
        name: "Test Form",
        description: "A test description",
        processed_in_job: false
      )
      expect(form).to be_valid
    end

    it "is invalid without a name" do
      form = Form.new(name: nil)
      expect(form).to_not be_valid
      expect(form.errors[:name]).to include("can't be blank")
    end

    it "requires processed_in_job to be boolean" do
      form = Form.new(name: "Test Form", processed_in_job: nil)
      expect(form).to_not be_valid
    end
  end

  # Test associations
  describe "associations" do
    it "has one response" do
      association = described_class.reflect_on_association(:response)
      expect(association.macro).to eq :has_one
    end
  end
end
