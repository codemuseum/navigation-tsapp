class Item < ActiveRecord::Base
  belongs_to :nav
  
  attr_protected :nav_id
  validates_presence_of :nav_id
  validates_presence_of :title
  validates_presence_of :link
  
  ###### Association Specific Code

  # Used for other models that might need to mark a item as *no longer* associated 
  attr_accessor :destroy_association

  # Used for other models (like an page_object) that might need to mark this item as *no longer* associated
  def destroy_association?
    destroy_association.to_i == 1
  end
end
