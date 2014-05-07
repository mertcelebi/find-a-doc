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
    if !(s.address.blank?)
      temp = Hospital.where(address: s.address,
                            city: s.city,
                            state: s.state,
                            zipcode: s.zipcode)
      @hospitals += temp
    end

    if @hospitals.empty?
      temp = Hospital.where(city: s.city,
                            state: s.state,
                            zipcode: s.zipcode)
      @hospitals += temp
    end

    if @hospitals.empty?
      temp = Hospital.where(state: s.state,
                            zipcode: s.zipcode)
      @hospitals += temp
    end
    
    if @hospitals.empty?
      temp = Hospital.where(state: s.state)
      @hospitals += temp
    end
    
    # Arrays for doctors
    @doctors_spec = []
    @doctors_code = []
    @doctors_symptom = []
    @doctors = []

    @hospitals.each do |hospital|
      hid = hospital.id.to_s
      
      # If specialty is present
      if s.specialty
        all_providers = Provider.where(hospital_id: hid)
        all_providers.each do |prov|
          pid = prov.id.to_s
          spec = Specialty.find_by(name: s.specialty, provider_id: pid)
          if spec
            @doctors_spec << prov
          end 
        end
      end

      # If ICD-9 code is present
      if s.icd_9
        code = Icd9.find_by(icd9_code: s.icd_9)
        if code
          sid = code.specialty_id.to_s
          spec = Specialty.find_by(id: sid)
          if spec
            all_providers = Provider.where(hospital_id: hid)
            all_providers.each do |prov|
              pid = prov.id.to_s
              sp = Specialty.find_by(name: spec.name, provider_id: pid)
              if sp
                @doctors_code << prov
              end
            end
          end
        end
      end

      # If Symptom is present
      if s.symptom
        code = Symptom.find_by(name: s.symptom)
        if code
          sid = code.specialty_id.to_s
          spec = Specialty.find_by(id: sid)
          if spec
            all_providers = Provider.where(hospital_id: hid)
            all_providers.each do |prov|
              pid = prov.id.to_s
              sp = Specialty.find_by(name: spec.name, provider_id: pid)
              if sp
                @doctors_symptom << prov
              end
            end
          end
        end
      end

      # Search with only location
      if (s.symptom.blank?) && (s.specialty.blank?) && (s.icd_9.blank?)
        temp = Provider.where(hospital_id: hid)
        @doctors += temp
      end
    end
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
