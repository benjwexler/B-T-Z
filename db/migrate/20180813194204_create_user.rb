class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.string :email
      t.integer :birth_month
      t.integer :birth_day
      t.integer :birth_year
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
