FactoryGirl.define do

  factory :user do
    name "Bernardo Rufino"
    email "bermonruf@gmail.com"
    password "123456"
    password_confirmation "123456"
    
    factory :user_with_member do
      association Inheritance.child_of(:user), factory: :member
    end
  end
  
  factory :other_user, class: User do
    name "Aragorn Arathorn"
    email "aragorn@gmail.com"
    password "123456"
    password_confirmation "123456"
    
    factory :other_user_with_child do
      association Inheritance.child_of(:user), factory: :lender
    end
  end
  
  # u = User.new(name: "Bernardo Rufino", email: "bermonruf@gmail.com", password: "123456", password_confirmation: "123456")
  # v = User.new(name: "Aragorn Arathorn", email: "aragorn@gmail.com", password: "123456", password_confirmation: "123456")
  # l = Lender.new(credit: 200.5)
  # m = Member.new
  
end