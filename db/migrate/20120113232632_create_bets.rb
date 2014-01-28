class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :numbers

      t.timestamps
    end
  end
end
