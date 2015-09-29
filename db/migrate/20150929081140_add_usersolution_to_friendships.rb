class AddUsersolutionToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :usersolution, :string
    add_column :friendships, :friendsolution, :string
  end
end
