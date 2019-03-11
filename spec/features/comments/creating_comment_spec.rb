require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

RSpec.feature "Adding comments" do
  before do
      DatabaseCleaner.clean
      @movie = create(:movie)
      @user = create(:user)
      @user.confirm
  end

  scenario "works for logged user" do
    sign_in @user

    visit movie_path(@movie)

    fill_in 'comment_body', with: "This is great"

    click_button "Create Comment"
    expect(page).to have_content("This is great")
    expect(page).to have_content("Comment has been added")
  end

  scenario "can't be done for not logged user" do
    visit movie_path(@movie)
    expect(page).not_to have_button("Create Comment")
  end

  scenario "can't be done for user who already commented" do
    create(:comment, user: @user, movie: @movie)
    sign_in @user

    visit movie_path(@movie)
    expect(page).not_to have_button("Create Comment")
  end

  scenario "works for user who already commented, but deleted the comment" do
    create(:comment, user: @user, movie: @movie)
    sign_in @user

    visit movie_path(@movie)
    expect(page).not_to have_button("Create Comment")
    click_link("Delete my comment")
    expect(page).to have_button("Create Comment")
  end
end
