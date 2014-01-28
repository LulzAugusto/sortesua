module ApplicationHelper
  def menu
    if user_signed_in?
      render 'devise/menu/user_menu'
    else
      render 'devise/menu/regular_menu'
    end
  end
end
