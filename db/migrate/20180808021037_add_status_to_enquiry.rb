class AddStatusToEnquiry < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :status, :integer, default: 0
  end
end
