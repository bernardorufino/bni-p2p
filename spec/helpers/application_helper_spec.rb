require 'spec_helper'

describe ApplicationHelper do

  describe "#title" do
  
    context "when view doesn't specify custom title'" do
      subject { helper.title }
      it { should == ApplicationHelper::TITLE }
    end
    
    context "when view specifies custom title" do
      before { view.provide :title, "custom" }
      subject { helper.title }
      it { should match(/custom/) }
      it { should match(ApplicationHelper::TITLE) }    
    end
  
  end

  describe "#flash_messages" do
  
    context "when no flash is set" do
      specify { helper.flash_messages.should be_empty }
    end
  
    [:success, :info, :alert, :error].each do |type|
    
      context "when flash[#{type}] is assigned" do
        before { controller.flash.now[type] = "message" }
        subject { helper.flash_messages.capybara }
        it { should have_selector('.alert', text: "message") }
        it { should have_selector(".alert-#{type}") } unless type == :alert
      end
      
    end
    
    # In fact, plural flashes, but keepin' it simple, otherwise
    # we could use Array#combination 4 times
    t1, t2 = :error, :info; # Not :alert
    context "when flash #{t1} and #{t2} are assigned" do
        before do
          controller.flash.now[t1] = t1.to_s;
          controller.flash.now[t2] = t2.to_s;
        end
        subject { helper.flash_messages.capybara }
        it { should have_selector(".alert.alert-#{t1}", text: t1.to_s) }
        it { should have_selector(".alert.alert-#{t2}", text: t2.to_s) }
    end
    
    context "when flash[notice] is assigned" do
      before { controller.flash.now[:notice] = "message" }
      subject { helper.flash_messages.capybara }
      it "should mimic success output" do
        should have_selector('.alert', text: "message")
        should have_selector('.alert-success')
      end
      it { should_not have_selector('.alert-notice') }
    end
   
  end
  
  describe "#icon" do
    
    shared_examples "icon" do |icon, opts={}|
      subject { helper.icon(icon, opts[:provide] || {}).capybara }
      let(:img) { subject.find('img') }
      
      it { should have_selector('img.icon') }
      if opts[:size]
        specify { img['width'].should == opts[:size][0].to_s }
        specify { img['height'].should == opts[:size][1].to_s }
      end
      specify { img['src'].should == icon_path("#{icon}.png") }    
    end
    
    it_should_behave_like "icon", 'resultset_next';
    
    context "when size provided" do
      it_should_behave_like "icon", 'resultset_next', size: [31, 42], provide: {
        width: 31,
        height: 42
      };      
    end    
    
    context "when given prefix g_ (glyphicon)" do 
      subject { helper.icon('g_user').capybara }
      it { should have_selector('i.icon-user') }
      
      context "and attributes id and class" do
        subject { helper.icon('g_user', class: 'class', id: 'id').capybara }
        it { should have_selector('i#id.icon-user.class') }
      end
        
    end
    
    context "when given prefix g_white_ (white glyphicon)" do
      subject { helper.icon('g_white_user') }
      it { should have_selector('i.icon-user.icon-white') }
    end
  
  end
  
  describe "#icon_text" do
    
    def self.spec_icon_text(icon, text, attrs={})
      context "when given icon #{icon.inspect} and text #{text.inspect} with attributes #{attrs.inspect}" do
        subject { icon_text(icon, text, attrs) }
        it { should start_with(icon(icon, attrs)) }
        it { should end_with(text) }
      end
    end
    
    spec_icon_text 'g_user', "Usuario"
    spec_icon_text 'g_user', "Usuario", id: 'id', class: 'class'
    spec_icon_text 'g_white_user', "Usuario"
    spec_icon_text 'resultset_next', "Play"
    spec_icon_text 'resultset_next', "Play", id: 'id', class: 'class', width: 16, height: 16
    
  end
  
  describe "#text_icon" do
    
    def self.spec_text_icon(icon, text, attrs={})
      context "when given text #{text.inspect} and icon #{icon.inspect} with attributes #{attrs.inspect}" do
        subject { text_icon(text, icon, attrs) }
        it { should start_with(text) }
        it { should end_with(icon(icon, attrs)) }
      end
    end
    
    spec_text_icon "Usuario", 'g_user' 
    spec_text_icon "Usuario", 'g_user', id: 'id', class: 'class'
    spec_text_icon "Usuario", 'g_white_user' 
    spec_text_icon "Play", 'resultset_next' 
    spec_text_icon "Play", 'resultset_next', id: 'id', class: 'class', width: 16, height: 16
    
  end
  
  describe "#button" do
  
    context "when given only content" do
      subject { helper.button("Sample").capybara }  
      it { should have_selector('button.btn', text: "Sample") }  
    end
    
    # :primary, :info, :success, :warning, :danger, :inverse, :link
    type = :primary; 
    context "when given type and content" do
      subject { helper.button(type, "Sample").capybara }
      it { should have_selector('button.btn', text: "Sample") }  
      it { should have_selector(".btn-#{type}", text: "Sample") }
    end
    
    context "when given content and extra class" do
      subject { helper.button("Sample", class: 'extra-class').capybara }
      it { should have_selector('button.btn', text: "Sample") }  
      it { should have_selector('.extra-class') }
    end
  
    context "when given content and no type attribute" do
      subject { helper.button("Sample").capybara } 
      it { should have_selector('button[type="button"]') }
    end
    
    context "when given content and type attribute" do
      subject { helper.button("Sample", type: 'submit').capybara } 
      it { should have_selector('button.btn', text: "Sample") }  
      it { should have_selector('button[type="submit"]') }
    end
  
  end
  
  describe "#button_to" do
  
    context "when given path and content as string" do
      subject { helper.button_to("Content", '/path').capybara }
      it { should have_selector('a.btn') }
    end
    
    context "when given path and content as block" do
      subject { helper.button_to('/path'){"Content"}.capybara }
      it { should have_selector('a.btn') }
    end
    
    context "when given path, content and extra class" do
      subject { helper.button_to("Content", '/path', class: 'extra-class').capybara }
      it { should have_selector('a.btn.extra-class') }
    end
  
  end  

  describe "#nav" do
    
    let(:current_path) { page_path(:home) }
    before { controller.request.path = current_path }
    
    subject do
      helper.nav(id: 'foo', class: 'bar') do |m|
        m.item(id: 'home').link_to("Home", '/')                                  +  
        m.header { "Header" }                                                    +
        m.header(class: 'sample-class') { "Header" }                             +
        m.divider                                                                +
        m.divider(class: 'sample-class')                                           +
        m.disabled.link_to("Disabled", '/disabled')                              +
        m.link_to("Page", '/page')                                               +
        m.link_to("Current", current_path)                                       +
        m.item(class: 'sample-class').disabled.link_to("Current", current_path)  +
        m.item(class: 'sample-class') { "<span>Generic</span>".html_safe }  
      end.capybara
    end
    
    it { should have_selector('ul#foo.bar.nav' ) }
    it { should have_selector('ul li#home a[href="/"]', text: "Home") }
    it { should have_selector('ul li.nav-header', text: "Header") }
    it { should have_selector('ul li.nav-header.sample-class', text: "Header") }
    it { should_not have_selector('ul li.divider.nav-header') }
    it { should have_selector('ul li.divider') }
    it { should have_selector('ul li.divider.sample-class') }
    it { should have_selector('ul li.disabled a[href="/disabled"]', text: "Disabled") }
    it { should have_selector('ul li a[href="/page"]', text: "Page") }
    it { should have_selector("ul li.active a[href=\"#{current_path}\"]", text: "Current") }
    it { should have_selector("ul li.sample-class.disabled.active a[href=\"#{current_path}\"]", text: "Current") }
    it { should have_selector('ul li.sample-class span', text: "Generic") }
  
    context "when tag ol is given" do
      subject { helper.nav(tag: 'ol').capybara }
      it { should have_selector('ol') }
    end
    
    context "when calls are wrapped with 'with' method" do
      subject do 
        helper.nav do |m|
          m.with(class: 'sample-class') do |m|
            m.item(class: 'sample-class2') { "<span>Generic</span>".html_safe } + 
            m.link_to("Page", "/page")
          end
        end.capybara
      end
      it { should have_selector('ul li.sample-class.sample-class2 span', text: "Generic") }
      it { should have_selector('ul li.sample-class a[href="/page"]', text: "Page") }
    end 
    
    context "when nav is manually set to false" do
        subject { helper.nav(nav: false).capybara }
        it { should_not have_selector('ul.nav') }
    end
    
    context "when nav is manually set to false and a class is given" do
        subject { helper.nav(class: 'menu', nav: false).capybara }
        it { should_not have_selector('ul.nav') }
        it { should have_selector('ul.menu') }
    end
    
  end

end