class PageObject < ActiveRecord::Base
  include ThriveSmartObjectMethods
  self.caching_default = :any_page_update
  
  belongs_to :nav
  
  attr_protected :nav_id
  # validates_presence_of :nav_id  -- Interferes with the code below, when nav is a new object
  
  # Pass the buck and actually save the nav
  after_update :save_nav
  
  # Creates a new nav if it doesn't exist for the sent in organization
  def self.new_by_site_uid(site_uid, attr_hash)
    nav = Nav.find_by_site_uid(site_uid)
    if nav.nil?
      nav = Nav.new
      nav.site_uid = site_uid
    end
    new(attr_hash.merge({:nav => nav}))
  end
  
  def validate
    unless nav.valid?
      errors.add(:nav, " has an error that must be corrected.")
    end
  end
  
  # Passes the buck of the hash passed in to the actual nav model
  def assigned_nav=(hash)
    self.nav.attributes = hash
  end
  
  protected
    def save_nav
      nav.save
    end
end
