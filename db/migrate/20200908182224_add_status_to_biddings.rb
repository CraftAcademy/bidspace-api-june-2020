class AddStatusToBiddings < ActiveRecord::Migration[6.0]
  def change
    add_column :biddings, :status, :integer,  default: 0
  end
end
