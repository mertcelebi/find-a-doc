class UsersController < ApplicationController
  
  before_action :sign_in_user, only:  [:edit, :update]
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
    @searches = @user.searches.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Find-a-Doc! Your registration is successful."
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "You have successfully updated your profile."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "You have successfully deleted a user."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :zipcode, :password,
                                   :password_confirmation)
    end

    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
