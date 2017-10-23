class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :bio
      t.string :activation_digest
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.boolean :accepted, default: false
      t.string :confirmation_digest
      t.boolean :confirmed, default: false
      t.datetime :confirmation_sent_at
      t.datetime :confirmed_at

      t.timestamps

    end
    add_index :requests, :email
  end
end
