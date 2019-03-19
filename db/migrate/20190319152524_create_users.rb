class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :reset_token
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
