class ChangeNameLimitOfLotteries < ActiveRecord::Migration
  def up
    execute("UPDATE lotteries SET name = SUBSTR(name, 1, 255)")
    change_column(:lotteries, :name, :string, limit: 255)
  end

  def down
    change_column(:lotteries, :name, :string, limit: nil)
  end
end
