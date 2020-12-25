class AddPlanToPayments < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :plan, null: false, foreign_key: true
  end
end
