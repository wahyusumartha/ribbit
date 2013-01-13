class CreateRibbits < ActiveRecord::Migration
  def change
    create_table :ribbits do |t|
      t.text :content
      t.references :user

      t.timestamps
    end
    add_index :ribbits, :user_id
  end
end
