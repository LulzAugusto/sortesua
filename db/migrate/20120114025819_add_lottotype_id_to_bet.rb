class AddLottotypeIdToBet < ActiveRecord::Migration
  def change
    add_column :bets, :lottotype_id, :integer
  end
end
