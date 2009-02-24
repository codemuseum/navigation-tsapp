class CreateNavs < ActiveRecord::Migration
  def self.up
    create_table :navs do |t|
      t.string :site_uid
      t.timestamps
    end
    add_index :navs, :site_uid
  end

  def self.down
    drop_table :navs
  end
end
