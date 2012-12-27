class User < ActiveRecord::Base
  include Inheritance::ParentBehavior
  
  parent_of :lender, :member
  
  # :token_authenticatable, :confirmable, :lockable, :timeoutable and :omniauthable, :validatable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable

  attr_accessible :email, :name, :password, :password_confirmation, :remember_me
 
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    
  validates :name,
    presence: true,
    length: { maximum: 50 }
    
  validates :password,
    presence: true,
    confirmation: true,
    length: { minimum: 6 }
    
  validates :password_confirmation,
    presence: true
    
  validates :encrypted_password,
    presence: true
  
 # before_save { email.downcase! }
  
end
