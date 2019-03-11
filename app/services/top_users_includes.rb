class TopUsersIncludes
  def call(time)
    data = User.includes(:comments)

    users = data.all.map do |user|
      new_comments = user.comments.select{ |comment| comment.created_at >  time }
      [user.name, new_comments.size]
    end

    users.sort_by{ |user| user[1]}.reverse.first(10)
  end
end
