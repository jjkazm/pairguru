module CommentsHelper

    #Renders new comment form or denies access depending on user, comment and movie
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

    # Returns current users's comment of the movie
    def comment_of_current_user
      if user_signed_in?
        @movie = Movie.find(params[:movie_id] || params[:id])
        @comment = @movie.comments.find_by(user_id: current_user.id)
      end
    end

end
