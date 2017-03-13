class KanjiLetter < ActiveRecord::Base
  belongs_to :kanji
  belongs_to :letter
end
