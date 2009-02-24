class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.references :nav
      t.integer :position
      t.string :title
      t.string :link
      t.string :class_name

      t.timestamps
    end
    add_index :items, :nav_id
    add_index :items, :position
  end

  def self.down
    drop_table :items
  end
end
