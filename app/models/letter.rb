class Letter < ActiveRecord::Base
  has_many :meanings
  has_many :pronunciations
  has_many :kanji_letters, dependent: :destroy
  has_many :kanjis, :through => :kanji_letters
end
