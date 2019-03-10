require "spec_helper"

describe CommentsHelper do
  describe "#comment_of_current_user" do
    let(:subject) {helper.comment_of_current_user}
    context "with no params" do
      it "returns nil" do
        expect(subject).to be_nil
      end
    end
    context "with valid params" do
      before do
        @owner = create(:user)
        @owner.confirm
        @non_author = create(:user)
        @non_author.confirm
        @movie = create(:movie)
        params[:movie_id] = @movie.id
        @comment = create(:comment, user: @owner, movie: @movie)
      end

      context "and logged author of comment" do
        before { sign_in @owner }
        it "returns comment" do
          expect(subject).to eql(@comment)
        end
      end

      context "and logged other user" do
        before { sign_in @non_author }
        it "returns nil" do
          expect(subject).to be_nil
        end
      end
      context "and not logged user" do
        it "returns nil" do
          expect(subject).to be_nil
        end
      end
    end
  end

  describe "#add_comment" do
    let(:subject) { helper.add_comment }
    before do
      @owner = create(:user)
      @owner.confirm
      @non_author = create(:user)
      @non_author.confirm
      @movie = create(:movie)
      params[:movie_id] = @movie.id
      @comment = create(:comment, user: @owner, movie: @movie)
    end
    context "with not signed user" do
      it "asks for login or registration" do
        expect(subject).to have_content("Please login or register in order to comment")
      end
    end

    context "with logged user who already commented" do
      before { sign_in @owner }
      it "restricts new comment and advise deleting previous comment" do
        expect(subject).to have_content("You have commented on the #{@movie.title}")
      end
    end

    context "with logged user who has not commented yet" do
      before { sign_in @non_author }
      it "displays form" do
        expect(subject).to have_css("textarea#comment_body")
      end
    end

  end
end
