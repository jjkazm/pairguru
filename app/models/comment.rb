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

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie
end
