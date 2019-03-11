class NewComment

  def initialize(user, params)
    @movie_id = params[:movie_id]
    @body = params[:comment][:body]
    @user = user
  end

  def call
    @movie = Movie.find(@movie_id)
    @comment = @movie.comments.build(body: @body, user: @user)
  end
end
