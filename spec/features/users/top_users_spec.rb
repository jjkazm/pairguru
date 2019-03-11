require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.feature "Top page" do
  before do
      DatabaseCleaner.clean
      #most active user with 5 comments in last week
      @best = create(:user)
      @best.confirm
      5.times do
        create(:comment, user: @best)
      end

      #10 regular users with 1 comment in last week
      10.times do
        regular = create(:user)
        regular.confirm
        create(:comment, user: regular)
      end

      #user with 5 old comments and no comments in last week
      @late = create(:user)
      @late.confirm
      5.times do
        create(:comment, user: @late, created_at: 2.weeks.ago)
      end
  end
  scenario "with 1 very active user, 10 regulars and 1 inactive" do
    visit "/top"
    expect(page).to have_content("Most active users this week")
    expect(page).to have_content("#{@best.name}")
    expect(page).not_to have_content("#{@late.name}")
    expect(page).to have_css("div.top_user")
  end

  scenario "after creating 2 posts user appears on list" do
    2.times do
      create(:comment, user: @late)
    end
    visit "/top"
    expect(page).to have_content("#{@late.name}")
  end

  scenario "after deleting all comments user should not appear on the list" do
    @best.comments.each { |comment| comment.destroy }
    visit "/top"
    expect(page).not_to have_content("#{@best.name}")
  end

end
