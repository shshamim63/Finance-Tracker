class AddStockNumberToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :stock_number, :integer
  end
end
