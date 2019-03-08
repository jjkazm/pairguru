# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  movie_id   :integer
#

FactoryBot.define do
  factory :comment do
    body { "MyString" }
    user
    movie
  end
end
