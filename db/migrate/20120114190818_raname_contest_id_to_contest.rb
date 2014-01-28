class RanameContestIdToContest < ActiveRecord::Migration
  def up
    rename_column :results, :contest_id, :contest
  end

  def down
    rename_column :results, :contest, :contest_id
  end
end
