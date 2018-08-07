class CreateEnquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.string :message
      t.references :source, foreign_key: { to_table: :websites }

      t.timestamps
    end
  end
end
