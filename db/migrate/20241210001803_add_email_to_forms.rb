class AddEmailToForms < ActiveRecord::Migration[7.2]
  def change
    add_column :forms, :email, :string
  end
end
