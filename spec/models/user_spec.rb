require 'spec_helper'

describe User do
  before(:each) do
    @user = create(:user)
  end

  subject { @user }

  # Validate fields
  context "on create" do
    # FactoryGirl
    it "has a valid factory" do 
      should be_valid
    end

    # Validate fields
    it "responds to name" do 
      should respond_to(:name)
    end

    it "responds to email" do 
      should respond_to(:email)
    end

    it "responds to uid" do 
      should respond_to(:id)
    end

    it "responds to password_digest" do 
      should respond_to(:password_digest)
    end

    it "responds to password" do 
      should respond_to(:password)
    end

    it "responds to password_confirmation" do 
      should respond_to(:password_confirmation)
    end

    it "responds to address" do 
      should respond_to(:address)
    end

    it "responds to city" do 
      should respond_to(:city)
    end

    it "responds to state" do 
      should respond_to(:state)
    end

    it "responds to zipcode" do 
      should respond_to(:zipcode)
    end

    it "responds to searches" do 
      should respond_to(:searches)
    end

    it "responds to feed" do 
      should respond_to(:feed)
    end

    # Validate presence
    it "is invalid without a name" do
      build(:user, name: nil).should_not be_valid
    end
    
    it "is invalid without a email" do
      build(:user, email: nil).should_not be_valid
    end
    
    it "is invalid without a password" do
      build(:user, password: nil).should_not be_valid
    end

    it "is invalid without a city" do
      build(:user, city: nil).should_not be_valid
    end

    it "is invalid without a state" do
      build(:user, state: nil).should_not be_valid
    end

    it "is invalid without a zipcode" do
      build(:user, zipcode: nil).should_not be_valid
    end

    it "is invalid when state is too long" do
      build(:user, state: "a" * 3).should_not be_valid
    end

    it "is invalid when state is too short" do
      build(:user, state: "a" * 1).should_not be_valid
    end

    it "is invalid when zipcode is too short" do
      build(:user, zipcode: "a" * 4).should_not be_valid
    end

    it "is invalid when zipcode is too long" do
      build(:user, zipcode: "a" * 6).should_not be_valid
    end

    it "is invalid when password does not match confirmation" do
      build(:user, password: "abc123456", 
            password_confirmation: "abc1234567").should_not be_valid
    end

    it "is invalid when password is too short" do
      build(:user, password: "a" * 5,
            password_confirmation: "a" * 5).should_not be_valid
    end

    describe "when email format is invalid" do

      it "should be invalid" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                       foo@bar_baz.com foo@bar+baz.com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end

    describe "when email format is valid" do

      it "should be valid" do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end

    # Validate uniqueness
    it "is invalid when email address is already taken" do
      build(:user, email: @user.email).should_not be_valid
    end

    describe "return value of authenticate method" do

      before { @user.save }
      let(:found_user) { User.find_by(email: @user.email) }

      describe "with valid password" do
        
        it { should eq found_user.authenticate(@user.password) }
      end

      describe "with invalid password" do

        let(:user_for_invalid_password) { found_user.authenticate("invalid") }
        
        it { should_not eq user_for_invalid_password }
        specify { expect(user_for_invalid_password).to be_false }
      end

      describe "with a password that's too short" do
        
        before { @user.password = @user.password_confirmation = "a" * 5 }
        
        it { should be_invalid }
      end
    end

    describe "remember token" do
      before { @user.save }
      
      its(:remember_token) { should_not be_blank }
    end 

    describe "search associations" do
      before { @user.save }
      let!(:older) do
        create(:search, user: @user, created_at: 1.day.ago)
      end
      let!(:newer) do
        create(:search, user: @user, created_at: 1.hour.ago)
      end

      it "should have the right searches in the right order" do
        expect(@user.searches.to_a).to eq [newer, older]
      end

      it "should destroy associated searches" do
        searches = @user.searches.to_a
        @user.destroy
        expect(searches).not_to be_empty
        searches.each do |search|
          expect(Search.where(id: search.id)).to be_empty
        end
      end
    end
  end
end