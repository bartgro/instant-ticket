class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.integer :available
      t.belongs_to :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
