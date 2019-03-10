class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :comment_of_current_user, only: [:show]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    @comments = @movie.comments.all.order(created_at: :desc)

  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end



  def comment_of_current_user
    if user_signed_in?
      @movie = Movie.find(params[:id])
      @comment = @movie.comments.find_by(user_id: current_user.id)
    end
  end
  helper_method :comment_of_current_user
end
