class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :category
      t.string :lead
      t.integer :scene

      t.timestamps
    end
  end
end
