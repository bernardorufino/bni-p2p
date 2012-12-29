require 'spec_helper'

describe User do
  
  subject(:user) { build(:user) }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_me) }
  
  context "when associated with a child" do
    subject(:user) { build(:user) }
    before do
      user.child = Member.new
      user.child.user = user
      user.child.save!
    end
    it "should destroy without infinity loop" do
      expect{ user.destroy }.not_to raise_error(SystemStackError)
    end
  end
  
  context "when saving with upcased email" do
    subject { create(:user, email: build_stubbed(:user).email.upcase) }
    its(:email) { should be_downcased }
  end 
 
  context "when setting a child" do
    before { user.child = build(:member) }
    specify { user.child.user.should == user }
  end
  
  describe "validations" do
  
    subject { build(:user) }
    
    context "when valid" do
      it { should be_valid }
    end
    
    context "when associated with a valid child" do
      subject { build(:user_with_member) }
      it { should be_valid }
    end
    
    context "when associated with an invalid child" do
      subject { build(:user_with_member) }
      it "shouldn't validate the child"
    end
    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_presence_of(:password_confirmation) }
    it { should_not allow_value(nil).for(:password_confirmation) }
    it { should ensure_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
    it { should validate_uniqueness_of(:email) } 
    it { should ensure_length_of(:name).is_at_most(50) }

   %w[user@foo,com user_at_foo.org exemple.user@foo. foo@bar_baz.com foo@bar+baz.com].each do |email|
      context "when given invalid email #{email}" do
        subject { build(:user, email: email) }
        it { should_not be_valid }
      end
    end
    
    %w[user@foo.COM US-ER@f.b.org frst.lst@foo.jp ab@baz.cn].each do |email|
      context "when given valid email #{email}" do
        subject { build(:user, email: email) }
        it { should be_valid }    
      end  
    end
    
    context "when email is already taken with different capitalization" do
      before do
        m = build(:member_with_user)
        m.user.email = subject.email.downcase
        m.save
        subject.email.upcase!
      end
      it { should_not be_valid }      
    end
    
  end

end