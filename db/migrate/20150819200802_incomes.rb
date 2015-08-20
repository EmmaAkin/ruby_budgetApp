class Incomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :title, null: false
      t.string :period, null: false, default: 'Monthly'
      t.integer :amount, null: false, default: 0

      t.timestamps(null: false)
    end
  end



  def down
    drop_table :incomes
  end
end
