class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :zip_code
      t.string :city
      t.string :country
      t.string :phone
      t.string :email
      t.belongs_to :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
