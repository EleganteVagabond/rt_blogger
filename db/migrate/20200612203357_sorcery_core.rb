class SorceryCore < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :email,            null: false
      t.string :username,         null: false
      t.string :nickname,         null: false      
      t.string :crypted_password
      t.string :salt

      t.timestamps                null: false
    end

    add_index :authors, :email, unique: true
    add_index :authors, :username, unique: true
  end
end
