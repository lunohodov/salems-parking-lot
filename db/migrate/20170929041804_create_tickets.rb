class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :barcode, limit: 16, null: false

      t.timestamps
    end

    add_index :tickets, :barcode, unique: true
  end
end
