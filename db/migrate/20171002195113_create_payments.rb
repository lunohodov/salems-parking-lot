class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.belongs_to :ticket, index: true
      t.integer :option, null: false
      t.integer :amount_in_euro_cents, null: false

      t.timestamps
    end
  end
end
