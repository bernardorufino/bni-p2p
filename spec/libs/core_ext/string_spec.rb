require 'spec_helper'

describe String do

  describe "#downcased?" do
  
    ["Foo", "FOO", "fOo"].each do |string|
      
      context "when is #{string.inspect} (not downcase)" do
        subject { string.downcased? }
        it { should == false }
      end
      
      context "when is #{string.inspect}.downcase" do
        subject { string.downcase.downcased? }
        it { should == true }
      end
      
    end
  
  end
  
  describe "#upcased?" do
  
    ["Foo", "foo", "fOo"].each do |string|
      
      context "when is #{string.inspect} (not upcase)" do
        subject { string.upcased? }
        it { should == false }
      end
      
      context "when is #{string.inspect}.upcase" do
        subject { string.upcase.upcased? }
        it { should == true }
      end
      
    end
  
  end

end