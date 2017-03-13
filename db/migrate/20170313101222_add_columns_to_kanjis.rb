class AddColumnsToKanjis < ActiveRecord::Migration
  def change
    add_column :kanjis, :taken_at, :time
    add_column :kanjis, :latitude, :float
    add_column :kanjis, :longitude, :float
  end
end
