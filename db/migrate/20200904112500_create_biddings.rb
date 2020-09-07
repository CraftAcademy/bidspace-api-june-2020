class CreateBiddings < ActiveRecord::Migration[6.0]
  def change
    create_table :biddings do |t|
      t.float :bid

      t.timestamps
    end
  end
end
