require 'rails_helper'

RSpec.feature "Adding comments" do
  before do
      @movie = create(:movie)
      @user = create(:user)
      @user.confirm
  end

  scenario "logged user adds comment" do
    sign_in @user
    
    visit movie_path(@movie)

    fill_in 'comment_body', with: "This is great"

    click_button "Create Comment"
    expect(page).to have_content("This is great")

  end
end
