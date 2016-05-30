class AddLotNumberToCandidates < ActiveRecord::Migration[5.0]
  def up
    add_column :candidates, :lot_number, :integer
    # 既存レコードはすべて追加抽選なく1回目で抽選されたことにしておく
    execute("UPDATE candidates SET lot_number = 1 WHERE winner = TRUE;")
  end

  def down
    remove_column :candidates, :lot_number, :integer
  end
end
