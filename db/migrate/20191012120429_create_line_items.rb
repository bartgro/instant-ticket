class CreateLineItems < ActiveRecord::Migration[6.0]
  def change
    create_table :line_items do |t|
      t.belongs_to :ticket, null: false, foreign_key: true
      t.decimal :unit_price
      t.integer :quantity
      t.belongs_to :order, null: false, foreign_key: true
      t.string :event_name

      t.timestamps
    end
  end
end
