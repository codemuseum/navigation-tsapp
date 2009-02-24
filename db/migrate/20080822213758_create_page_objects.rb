class CreatePageObjects < ActiveRecord::Migration
  def self.up
    create_table :page_objects do |t|
      t.references :nav
      t.string :urn

      t.timestamps
    end
    add_index :page_objects, :urn
    add_index :page_objects, :nav_id
  end

  def self.down
    drop_table :page_objects
  end
end
