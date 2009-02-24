class Nav < ActiveRecord::Base
  has_many :items, :order => :position, :dependent => :destroy
  has_many :page_objects

  attr_protected :site_uid
  validates_uniqueness_of :site_uid
  validates_presence_of :site_uid
  validates_associated :items

  attr_accessor :added_items
  after_save :save_items
  
  def validate
    unless self.added_items.nil?
      recorded_items_error = false
      self.added_items.each do |item|
        unless item.valid? or recorded_items_error
          errors.add(:items, " have an error that must be corrected.")
        end
      end
    end
  end

  # Responsible for removing and adding all items to this nav. The general flow is:
  #  If the item isn't a part of the items array already, save to added_items for after_save
  #  If the item is missing from the array, mark it to be removed for after_save 
  def assigned_items=(array_hash)
    # Find new items (but no duplicates)
    self.added_items = []
    array_hash.each do |h|
      unless items.detect { |c| c.id.to_s == h[:id] } || self.added_items.detect { |f| f.id.to_s == h[:id] }
        c = !h[:id].blank? ? Item.find(h[:id]) : Item.new({:nav => self}) # FIXME possible to form hack
        c.attributes = h.reject { |k,v| k == :id } # input values, but don't try to overwrite the id
        self.added_items << c unless c.nil?
      end
    end
    # Delete removed items
    items.each do |c|
      if h = array_hash.detect { |h| h[:id] == c.id.to_s }
        c.attributes = h.reject { |k,v| k == :id }
      else
        c.destroy_association = 1
      end
    end
  end
  
  protected
    # Destroy items marked for deletion, and adds items marked for addition.
    # Done this way to account for association auto-saves.
    def save_items
      self.items.each { |c| if c.destroy_association? then c.destroy else c.save end }
      self.added_items.each { |c| c.save unless c.nil? } unless self.added_items.nil?
    end
  
end
