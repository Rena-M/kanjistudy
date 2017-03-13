class ChangeTakenAtToKanjis < ActiveRecord::Migration
  def up
    change_column :kanjis, :taken_at, :datetime
  end

  def down
    change_column :kanjis, :taken_at, :time
  end
end
