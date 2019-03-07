require 'rails_helper'

RSpec.feature "Movie listing" do
  before { @movie = create(:movie, title: "Killer") }

  scenario "shows title of new movie" do
    visit '/movies'
    expect(page).to have_content("Killer")
  end
end
