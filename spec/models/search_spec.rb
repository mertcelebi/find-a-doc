require 'spec_helper'

describe Search do

  let(:user) { create(:user) }
  before(:each) do
    @search = user.searches.build(city: "NH", state: "CT", zipcode: "06511")
  end

  subject { @search }
  # FactoryGirl
  it "has a valid factory" do 
    should be_valid
  end

  # Validate fields
  it "responds to specialty" do 
    should respond_to(:specialty)
  end

  it "responds to symptom" do 
    should respond_to(:symptom)
  end

  it "responds to icd_9" do 
    should respond_to(:icd_9)
  end

  it "responds to state" do 
    should respond_to(:state)
  end

  it "responds to city" do 
    should respond_to(:city)
  end

  it "responds to address" do 
    should respond_to(:address)
  end

  it "responds to zipcode" do 
    should respond_to(:zipcode)
  end

  # Validate presence
  it "is invalid without a city" do
    build(:search, city: nil).should_not be_valid
  end
  
  it "is invalid without a state" do
    build(:search, state: nil).should_not be_valid
  end
  
  it "is invalid without a zipcode" do
    build(:search, zipcode: nil).should_not be_valid
  end

  it "is invalid when state is too long" do
    build(:search, state: "a" * 3).should_not be_valid
  end

  it "is invalid when state is too short" do
    build(:search, state: "a" * 1).should_not be_valid
  end

  it "is invalid when zipcode is too short" do
    build(:search, zipcode: "a" * 4).should_not be_valid
  end

  it "is invalid when zipcode is too long" do
    build(:search, zipcode: "a" * 6).should_not be_valid
  end
end
