class CreateShippingTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_types do |t|
      t.string :name
      t.decimal :cost
      t.integer :delivery_time

      t.timestamps
    end
  end
end
