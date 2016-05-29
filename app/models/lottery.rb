require "csv"

class Lottery < ActiveRecord::Base
  MESSAGE_TYPES = I18n.t('terms.choices.message_type').keys.map(&:to_s).freeze

  attr_accessor :candidates_csv

  validates :name, presence: true, length: { maximum: 255 }
  validates :winners_count, presence: true, numericality: { only_integer: true, greater_than: 0, allow_blank: true }
  validates :message_type, presence: true, inclusion: { in: MESSAGE_TYPES }

  has_many :candidates, dependent: :destroy
  accepts_nested_attributes_for :candidates, allow_destroy: true, reject_if: proc { |attrs| attrs['id'].blank? && attrs['name'].blank? }

  delegate :winners, to: :candidates

  class << self
    def human_message_type(message_type)
      I18n.t("terms.choices.message_type")[message_type.to_sym]
    end

    def message_type_choices
      I18n.t('terms.choices.message_type').invert
    end
  end

  def human_message_type
    self.class.human_message_type(message_type)
  end

  def redrawable?
    winners_count > winners.count
  end

  def last_lot_number
    candidates.maximum(:lot_number)
  end

  def last_winners
    return [] unless drawn?
    candidates.where(lot_number: last_lot_number)
  end

  def draw!
    lacked_winners_count = winners_count - winners.count
    return if drawn && lacked_winners_count <= 0

    rest_candidates = candidates.where(winner: false)

    winners = LotteryDrawer.draw(rest_candidates, lacked_winners_count)
    new_lot_number = last_lot_number.to_i + 1

    Lottery.transaction do
      winners.each do |winner|
        winner.update!(winner: true, lot_number: new_lot_number)
      end
      update!(drawn: true) unless drawn
    end
  end

  def draw
    draw!
    true
  rescue
    false
  end

  def import!(csv)
    self.candidates_csv = csv  # 検証エラー時の表示用などのためにセットだけしておく
    Lottery.transaction do
      CSV.parse(csv) do |row|
        name, weight = row
        next if name.blank?
        weight = weight.presence || Candidate::DEFAULT_WEIGHT

        candidate = candidates.find_by(name: name) || candidates.build(name: name)
        candidate.weight = weight.to_i
        candidate.save!
      end
    end
  end

  def import(csv)
    import!(csv)
    true
  rescue => e
    errors.add(:base, e.record.errors.full_messages.join("\n"))
    false
  end
end
