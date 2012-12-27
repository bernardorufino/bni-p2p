require 'spec_helper'

describe Inheritance do

  type = :user
  
  describe "#child_of" do
    subject { Inheritance.child_of(:user).to_s }
    it { should == "user_interface" }
  end
  
  describe "#column_type" do
    subject { Inheritance.column_type(type).to_s }
    it { should == "user_interface_type" }
  end 
  
  describe "#column_type" do
    subject { Inheritance.column_id(type).to_s }
    it { should == "user_interface_id" }
  end 
  
  describe "#columns" do
    subject { Inheritance.columns(type).map(&:to_s) }
    it { should include("user_interface_id", "user_interface_type") }
  end

end
