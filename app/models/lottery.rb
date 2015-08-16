class Lottery < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :winners_count, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: true }

  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates, reject_if: proc { |attrs| attrs['id'].blank? && attrs['name'].blank? }
end
