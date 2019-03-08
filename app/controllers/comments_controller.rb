class CommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html do
            flash[:success] = "Comment has been added"
           redirect_to movie_path(@movie)
        end
        format.js
      end
    else
      flash[:danger] = "#{@comment.errors.full_messages.first}"
      redirect_to movie_path(@movie)
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
