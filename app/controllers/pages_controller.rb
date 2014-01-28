class PagesController < ApplicationController
  layout 'index'
  
  def index
    if user_signed_in?
      redirect_to user_root_path
    else
      render :action => 'index'
    end
  end
end
