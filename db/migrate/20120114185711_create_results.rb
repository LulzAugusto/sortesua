class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :numbers
      t.datetime :published_at
      t.integer :contest_id
      t.references :lotto_type

      t.timestamps
    end
  end
end
