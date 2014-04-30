class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @search  = current_user.searches.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def about_us

  end
  
end

