class Member < ActiveRecord::Base
  include Inheritance::ChildBehavior
  
  is_one :user
  
  validates_presence_of :user
  
  
end
