class AddUserIdToBets < ActiveRecord::Migration
  def change
    add_column :bets, :user_id, :integer
  end
end
