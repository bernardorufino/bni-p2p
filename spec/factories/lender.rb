FactoryGirl.define do

  factory :lender do
    credit 200.5
    
    factory :lender_with_user do
      association :user, factory: :other_user
    end
  end

end