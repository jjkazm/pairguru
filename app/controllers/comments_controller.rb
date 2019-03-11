class CommentsController < ApplicationController
  before_action :set_movie
  def create
    @comment = NewComment.new(current_user, params).call
    authorize @comment
    if @comment.save
      respond_to do |format|
        format.html do
            flash[:notice] = "Comment has been added"
           redirect_to movie_path(@movie)
        end
        format.js { flash[:notice] = "Comment has been added" }
      end
    else
      flash[:danger] = "Comment has NOT been added. #{@comment.errors.full_messages.first}"
      redirect_to movie_path(@movie)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    flash[:notice] = "Comment has been deleted"
    redirect_to movie_path(@movie)
  end

  private
    def set_movie
      @movie = Movie.find(params[:movie_id])
    end
end
