class AddPercentageToFriendship < ActiveRecord::Migration
  def change
    add_column :friendships, :percentage, :text
  end
end
