class Kanji < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  has_many :kanji_letters, dependent: :destroy
  has_many :letters, :through => :kanji_letters

  accepts_nested_attributes_for :kanji_letters, allow_destroy: true

  belongs_to :user
end
