# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  movie_id   :integer
#

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:movie) }
  it { should validate_presence_of(:body)}
  it { should validate_length_of(:body).is_at_least(5).on(:create)}
  it { should validate_length_of(:body).is_at_most(250).on(:create)}
  it { should validate_uniqueness_of(:user_id).scoped_to(:movie_id).on(:create)
                            .with_message(" can comment only once per movie")}
end
