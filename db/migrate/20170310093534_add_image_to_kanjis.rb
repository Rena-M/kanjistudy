class AddImageToKanjis < ActiveRecord::Migration
  def change
    add_column :kanjis, :image, :string
  end
end
