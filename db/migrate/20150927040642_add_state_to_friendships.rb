class AddStateToFriendships < ActiveRecord::Migration
  def change
	add_column :friendships, :state, :string, :default => "pending"
  end
end
