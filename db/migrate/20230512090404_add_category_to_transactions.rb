class AddCategoryToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :category, :string, null: false
  end
end
