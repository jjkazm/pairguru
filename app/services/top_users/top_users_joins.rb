class TopUsersJoins
  def call(time)
    User.joins(:comments)
                      .where("comments.created_at > ?", time)
                      .group("users.name")
                      .order(Arel.sql("count(comments.id) desc"))
                      .count("comments.id")
                      .first(10)
  end
end
