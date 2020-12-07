class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.decimal :price, precision: 10, scale: 2
      t.string :name

      t.timestamps
    end
  end
end
