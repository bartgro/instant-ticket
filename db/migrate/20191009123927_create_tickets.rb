class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :kind
      t.decimal :price
      t.belongs_to :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
