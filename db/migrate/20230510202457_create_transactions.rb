class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :description
      t.decimal :amount, null: false, precision: 8, scale: 2, default: 0.0

      t.timestamps
    end
  end
end
