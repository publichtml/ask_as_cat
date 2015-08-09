class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.string :name, null: false
      t.integer :winners_count
      t.boolean :drawn, null: false, default: false

      t.timestamps null: false
    end
  end
end
