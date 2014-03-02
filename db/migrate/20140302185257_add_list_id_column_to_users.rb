class AddListIdColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :category, :string
    add_column :users, :tag, :string
  end
end
