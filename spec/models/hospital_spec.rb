require 'spec_helper'

describe Hospital do
  before(:each) do
    @hospital = create(:hospital)
  end

  subject { @hospital }
  # FactoryGirl
  it "has a valid factory" do 
    should be_valid
  end

  # Validate fields
  it "responds to state" do 
    should respond_to(:state)
  end

  it "responds to city" do 
    should respond_to(:city)
  end

  it "responds to address" do 
    should respond_to(:address)
  end

  it "responds to name" do 
    should respond_to(:name)
  end

  # Validate presence
  it "is invalid without a name" do
    build(:hospital, name: nil).should_not be_valid
  end
  
  # Validate uniqueness
  it "is invalid when name is already taken" do
    build(:hospital, name: @hospital.name).should_not be_valid
  end
end
