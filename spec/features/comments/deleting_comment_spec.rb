require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.feature "Deleting comments" do
  before do
    DatabaseCleaner.clean
    @comment = create(:comment)
    @comment.user.confirm
    @non_owner = create(:user)
    @non_owner.confirm
  end

  scenario "works for user who is owner of the comment" do
    sign_in @comment.user

    visit movie_path(@comment.movie)

    click_link ("Delete my comment")
    expect(page).to have_content("Comment has been deleted")
  end

  scenario "can't be done for not logged user" do
    visit movie_path(@comment.movie)

    expect(page).not_to have_link ("Delete my comment")
    expect(page).to have_content("Please login or register in order to comment")
  end

  scenario "can't be done for user " do
    sign_in @non_owner

    visit movie_path(@comment.movie)

    expect(page).not_to have_link ("Delete my comment")
    expect(page).to have_css("textarea#comment_body")
  end

  scenario "enables creating new comment" do
    sign_in @comment.user

    visit movie_path(@comment.movie)

    expect(page).not_to have_css("textarea#comment_body")

    click_link ("Delete my comment")
    expect(page).to have_content("Comment has been deleted")
    expect(page).to have_css("textarea#comment_body")
  end
end
