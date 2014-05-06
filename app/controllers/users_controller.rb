class UsersController < ApplicationController
  
  before_action :signed_in_user, only:  [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    # @search  = current_user.searches.build
    # @searches = @user.searches.paginate(page: params[:page])
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 4)
    s = @feed_items.first
    @hospitals = []
    print "#{s.address}\n"
    if !(s.address.blank?)
      print "1111111"
      @hospitals = Hospital.where(address: s.address,
                                  city: s.city,
                                  state: s.state,
                                  zipcode: s.zipcode)
    end

    if @hospitals.count == 0
      @hospitals = Hospital.where(city: s.city,
                                  state: s.state,
                                  zipcode: s.zipcode)
    end

    if @hospitals.count == 0
      @hospitals = Hospital.where(state: s.state,
                                  zipcode: s.zipcode)
    else
      @hospitals = Hospital.where(state: s.state)
    end

    @hospitals.each do |hospital|
      hid = hospital.id
      if !(s.specialty.blank?)
        spec = Specialty.find_by(name: s.specialty)
        sid = spec.provider_id
        @doctors << Provider.where(hospital_id: hid, id: sid)
      else
        @doctors << Provider.find_by(hospital_id: hid)
      end
    end
    @doctors = Provider.where(name: "Mert")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Find-a-Doc! Your registration is successful."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "You have successfully updated your profile."
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "You have successfully deleted a user."
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :address, :city, :state, 
                                   :zipcode, :password, :password_confirmation)
    end

    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
