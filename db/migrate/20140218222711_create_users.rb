class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :phone
      t.string :website
      t.string :hours
      t.string :other

      t.timestamps
    end
  end
end
