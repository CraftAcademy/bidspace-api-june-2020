class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :category
      t.text :lead
      t.string :scene

      t.timestamps
    end
  end
end
