class AddListingToBiddings < ActiveRecord::Migration[6.0]
  def change
    add_reference :biddings, :listing, null: false, foreign_key: true
  end
end
