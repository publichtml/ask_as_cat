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

  def import!(csv)
    self.candidates_csv = csv
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
