class AddResultToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :result, :text
  end
end
