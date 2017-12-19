class ModifyMembers1 < ActiveRecord::Migration[5.1]
  def change
  	add_column :members, :hashed_password, :string
  end
end
