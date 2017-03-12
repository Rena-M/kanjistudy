class Letter < ActiveRecord::Base
  has_many :meanings
  has_many :pronunciations
end
