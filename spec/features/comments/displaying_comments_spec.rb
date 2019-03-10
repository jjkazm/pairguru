require 'rails_helper'

RSpec.feature "comments listing" do
  before do
    @comment = create(:comment)
  end

  scenario "shows comment body and its author" do
    visit movie_path(@comment.movie)
    expect(page).to have_content(@comment.movie.title)
    expect(page).to have_content(@comment.user.name)
  end
end
