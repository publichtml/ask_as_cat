class AddUniqueIndexLotteryIdAndNameToCandidates < ActiveRecord::Migration
  def change
    add_index :candidates, [:lottery_id, :name], unique: true
  end
end
