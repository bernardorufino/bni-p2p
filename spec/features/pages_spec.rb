require 'spec_helper'

describe "pages" do

  shared_examples "having page" do |p|
    describe p.to_s do
      before { visit page_path(p) }
      subject { page }
      it { should have_selector('html') }
    end
  end

  it_behaves_like "having page", :home  
  
end

