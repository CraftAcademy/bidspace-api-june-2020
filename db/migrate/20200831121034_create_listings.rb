class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :type
      t.text :description
      t.string :scene
      t.integer :height
      t.string :address
      t.integer :price

      t.timestamps
    end
  end
end
