class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.string :exchange_id,                null: false, default: ''
    end

    create_table :exchanges_stocks, id: false do |t|
      t.string :exchange_id  # Exchange symbol
      t.string :symbol # Stock symbol
    end

    add_index :exchanges, :exchange_id, unique: true
  end
end
