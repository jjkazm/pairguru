module ApplicationHelper

  def add_comment
    if user_signed_in?
      if comment_of_current_user.nil?
        render partial: "comments/add_comment/form"
      else
        render partial: "comments/add_comment/already_commented"
      end
    else
      render partial: "comments/add_comment/not_logged"
    end
  end
  
end
