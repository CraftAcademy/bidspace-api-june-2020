class AddLandlordToListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :listings, :landlord, foreign_key: {to_table: :users} 
  end
end
