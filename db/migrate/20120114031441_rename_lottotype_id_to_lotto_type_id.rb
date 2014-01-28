class RenameLottotypeIdToLottoTypeId < ActiveRecord::Migration
  def up
    rename_column :bets, :lottotype_id, :lotto_type_id
  end

  def down
    rename_column :bets, :lotto_type_id, :lottotype_id
  end
end
