class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name, null: false, limit: 255
      t.boolean :winner, null: false, default: false
      t.integer :weight, null: false, default: 1
      t.integer :lottery_id, null: false

      t.timestamps null: false
    end
  end
end
