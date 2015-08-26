class AddMessageTypeToLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :message_type, :string, null: false, default: "lt"
  end
end
