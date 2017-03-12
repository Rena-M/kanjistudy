class CreateMeanings < ActiveRecord::Migration
  def change
    create_table :meanings do |t|
      t.string :meaning
      t.integer :letter_id

      t.timestamps null: false
    end
  end
end
