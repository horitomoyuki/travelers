class AddResidenceIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :residence_id, :integer
  end
end
