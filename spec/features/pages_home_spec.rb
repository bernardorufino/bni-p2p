require 'spec_helper'

describe "Home page" do
  before { visit page_path(:home) }
  subject { page }
  
  # Login form
  it { should have_selector('form[action="/users/login"]') }
  context "form" do
    subject { find('form[action="/users/login"]') }
    it { should have_selector('input[name="user[email]"]') }
    it { should have_selector('input[name="user[password]"]') }
    it { should_not have_selector('#header') }
  end
  
  # Registry button
  it { should have_link("Cadastrar", href: new_user_registration_path) }


  # Menu links
  it { should have_selector('#menu') }
  context("menu") do
    subject { find('#menu') }
    it { should have_link("Home", href: root_path) }
    it { should have_link("Emprestar") }
  end
  
end