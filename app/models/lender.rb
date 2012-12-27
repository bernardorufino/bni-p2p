class Lender < ActiveRecord::Base
  include Inheritance::ChildBehavior
  
  is_one :user
  
  attr_accessible :credit
  
  validates_presence_of :user
  
end
