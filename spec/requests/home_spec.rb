require "rails_helper"
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "Home requests", type: :request do
  describe "GET #top" do
    before do
      DatabaseCleaner.clean
      @adam = create(:user)
      @adam.confirm
      @movie = create(:movie)
    end
    subject { get "/top" }
    context "with not signed user" do
      it "renders top users page" do
        subject
        expect(response.body).to include("Most active users this week")
      end
    end
  end
end
