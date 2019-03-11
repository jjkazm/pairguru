class HomeController < ApplicationController
  def welcome; end

  def top

    #OPTION 1
    # Joins query, filtered at DB level (time: 1.7ms)
    # Fastest option, but doesn't show users with no comments, which should
    # not be a problem if website is popular
    @top_users = TopUsersJoins.new.call(7.days.ago)


    #OPTION 2
    # Includes query, filtered at application level (time: 6.8 ms)
    # @top_users = TopUsersIncludes.new.call(7.days.ago)

    #OPTION 3
    # eager_load or includes with conditions returns data in over 14ms
  end
end
