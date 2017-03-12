class CreatePronunciations < ActiveRecord::Migration
  def change
    create_table :pronunciations do |t|
      t.string :ja
      t.string :en
      t.integer :letter_id

      t.timestamps null: false
    end
  end
end
