class CreateKanjis < ActiveRecord::Migration
  def change
    create_table :kanjis do |t|
      t.integer :user_id
      t.string :word
      t.string :meaning
      t.string :pronunciation
      t.text :comment
      t.timestamps null: false
    end
  end
end
