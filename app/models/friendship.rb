# == Schema Information
#
# Table name: friendships
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  friend_id      :integer
#  friended_at    :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  state          :string           default("pending")
#  usersolution   :string
#  friendsolution :string
#  percentage     :text
#  result         :text
#

class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User"
end
