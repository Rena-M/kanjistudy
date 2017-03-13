class CreateKanjiLetters < ActiveRecord::Migration
  def change
    create_table :kanji_letters do |t|
      t.references :kanji, index: true, foreign_key: true
      t.references :letter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
