require 'spec_helper'

describe Lender do

  subject(:lender) { build(:lender) }
  
  it { should respond_to(:credit) }
  
  it { should have_one(:user).validate(true) }
  
  it { should be_child }
  it { should_not be_parent }
  it { should be_lender }
  it { should_not be_member }
  
  its(:child) { should == subject }
  its(:lender) { should == subject }
  its(:member) { should be_nil }

  its(:user) { should be_a_kind_of(User) }
  its(:user) { should be_new_record }
  
  describe "user" do
    subject(:user) { lender.user }
    its(Inheritance.column_type(:user)) { should == Lender.to_s }
  end
  
  context "when being saved without modifying user" do
    subject { lambda { lender.save! } }
    it { should raise_error(ActiveRecord::RecordInvalid) }
  end
  
  context "when being save with invalid user" do
    before { lender.user = build(:user, email: nil) }
    subject { lambda { lender.save! } }
    it { should raise_error(ActiveRecord::RecordInvalid) }
  end
  
  context "when being saved with valid user" do
    before { lender.user = build(:user) }
    subject { lambda { lender.save! } }
    it { should change{ lender.user.new_record? }.from(true).to(false) }
    it { should change{ User.count }.by(1) }
  end
  
end
