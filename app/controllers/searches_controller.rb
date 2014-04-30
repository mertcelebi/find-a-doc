class SearchesController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @search = current_user.searches.build(search_params)
    if @search.save
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def index

  end

  def destroy
    @search.destroy
    redirect_to root_url
  end

  private

    def search_params
      params.require(:search).permit(:zipcode)
    end

    def correct_user
      @search = current_user.searches.find_by(id: params[:id])
      redirect_to root_url if @search.nil?
    end

end
