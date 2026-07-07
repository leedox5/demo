class AddNameToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    reversible do |dir|
      dir.up do
        execute "UPDATE users SET name = email WHERE name = ''"
      end
    end
    change_column_default :users, :name, from: "", to: nil
  end
end
