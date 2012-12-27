require 'spec_helper'

describe Member do

  subject(:member) { build(:member) }
  
  context "when valid" do
    it { should { be_valid } }
  end
  
  it { should have_one(:user).validate(true) }
  
  it { should be_child }
  it { should_not be_parent }
  it { should be_member }
  it { should_not be_lender }
 
  its(:child) { should == subject }
  its(:member) { should == subject }
  its(:lender) { should be_nil }

  its(:user) { should be_a_kind_of(User) }
  its(:user) { should be_new_record }
  
  describe "user" do
    subject(:user) { member.user }
    its(Inheritance.column_type(:user)) { should == Member.to_s }
  end
  
  context "when being saved without modifying user" do
    subject { lambda { member.save! } }
    it { should raise_error(ActiveRecord::RecordInvalid) }
  end
  
  context "when being save with invalid user" do
    before { member.user = build(:user, email: nil) }
    subject { lambda { member.save! } }
    it { should raise_error(ActiveRecord::RecordInvalid) }
  end
  
  context "when being saved with valid user" do
    before { member.user = build(:user) }
    subject { lambda { member.save! } }
    it { should change{ member.user.new_record? }.from(true).to(false) }
    it { should change{ User.count }.by(1) }
  end  

end
