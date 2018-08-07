class CreateCarListings < ActiveRecord::Migration[5.2]
  def change
    create_table :car_listings do |t|
      t.string :make
      t.string :model
      t.string :colour
      t.integer :year
      t.string :reference
      t.string :url
      t.references :enquiry, foreign_key: true

      t.timestamps
    end
  end
end
