class Lottery < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :winners_count, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: true }

  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates, allow_destroy: true, reject_if: proc { |attrs| attrs['id'].blank? && attrs['name'].blank? }

  delegate :winners, to: :candidates

  def draw!
    if drawn
      errors.add(:base, I18n.t("errors.messages.already_drawed"))
      raise ActiveRecord::RecordInvalid.new(self)
    end

    winners = LotteryDrawer.draw(candidates, winners_count)

    Lottery.transaction do
      winners.each do |winner|
        winner.update!(winner: true)
      end
      update!(drawn: true)
    end
  end

  def draw
    draw!
  rescue
    false
  end
end
