class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks, id: false, force: true do |t|
      t.string :symbol, null: false, primary_key: true
      t.string :name
      t.string :stock_exchange
      t.string :color
    end

    add_index :stocks, :symbol, unique: true
  end
end
