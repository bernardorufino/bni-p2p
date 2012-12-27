FactoryGirl.define do

  factory :member do
    factory :member_with_user do
      association :user
    end
  end  

end