require 'spec_helper'

describe "User registration" do
  
  FORM_SELECTOR = 'form[action="/users"]'
  before { visit new_user_registration_path }
  subject { find(FORM_SELECTOR) }

  context "with invalid data" do
    it "should not create a user" do
      expect{ click_button("Cadastrar") }.not_to change{ User.count }
    end
  end
  
  context "with valid data" do
    before do
      user = build_stubbed(:user)
      within FORM_SELECTOR do
        fill_in 'user_name', with: user.name
        fill_in 'user_email', with: user.email
        fill_in 'user_password', with: user.password
      end
    end
  
    it "should create a user" do
      expect{ click_button("Cadastrar") }.to change{ User.count }
    end
  end

end