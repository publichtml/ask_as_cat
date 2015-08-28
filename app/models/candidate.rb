class Candidate < ActiveRecord::Base
  WEIGHTS = I18n.t('terms.choices.weight').keys.freeze
  DEFAULT_WEIGHT = 1

  belongs_to :lottery


  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { scope: [:lottery_id] }
  validates :weight, presence: true, inclusion: { in: WEIGHTS }

  default_scope { order(:id) }

  scope :winners, -> { where(winner: true) }

  class << self
    def human_weight(weight)
      I18n.t("terms.choices.weight")[weight]
    end

    def weight_choices
      I18n.t('terms.choices.weight').invert
    end
  end

  def human_weight
    self.class.human_weight(weight)
  end
end
