class Candidate < ActiveRecord::Base
  WEIGHTS = I18n.t('terms.choices.weight').keys.freeze

  default_scope { order(:id) }

  validates :name, presence: true, length: { maximum: 255 }
  validates :weight, presence: true, inclusion: { in: WEIGHTS }

  def self.weight_choices
    I18n.t('terms.choices.weight').invert
  end
end
