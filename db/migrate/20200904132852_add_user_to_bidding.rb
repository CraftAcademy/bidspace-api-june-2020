class AddUserToBidding < ActiveRecord::Migration[6.0]
  def change
    add_reference :biddings, :user, null: false, foreign_key: true
  end
end
