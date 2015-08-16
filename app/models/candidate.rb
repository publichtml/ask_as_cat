class Candidate < ActiveRecord::Base
  WEIGHTS = I18n.t('terms.choices.weight').keys.freeze

  default_scope { order(:id) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :weight, presence: true, inclusion: { in: WEIGHTS }

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
