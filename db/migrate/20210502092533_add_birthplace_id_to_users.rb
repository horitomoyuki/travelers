class AddBirthplaceIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthplace_id, :integer
  end
end
