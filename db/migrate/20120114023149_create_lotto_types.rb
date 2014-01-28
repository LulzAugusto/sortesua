class CreateLottoTypes < ActiveRecord::Migration
  def change
    create_table :lotto_types do |t|
      t.string :name
      t.integer :values
      t.timestamps
    end
  end
end
