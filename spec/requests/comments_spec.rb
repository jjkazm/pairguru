require "rails_helper"
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

describe "Comments requests", type: :request do
  describe "POST #create" do
    before do
      DatabaseCleaner.clean
      @adam = create(:user)
      @adam.confirm
      @movie = create(:movie)
    end
    subject { post "/movies/#{@movie.id}/comments", params:{comment: { body:"New comment" } }  }
    context "with signed in user" do
      it "creates comment" do
        sign_in @adam
        expect { subject }.to change { Comment.count }.by(1)
        expect( Comment.count ).to eq 1
      end
    end
  end

  describe " DELETE  #destroy" do
    before do
      DatabaseCleaner.clean
      @comment = create(:comment)
      @comment.user.confirm
    end
    subject { delete "/movies/#{@comment.movie_id}/comments/#{@comment.id}" }
    context "with user who is owner of the comment" do
      it "deletes the comment" do
        sign_in @comment.user
        expect { subject }.to change { Comment.count }.by(-1)
        expect( Comment.count ).to eq 0
      end
    end
  end

end
