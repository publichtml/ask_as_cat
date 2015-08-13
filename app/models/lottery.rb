class Lottery < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :winners_count, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: true }
end
