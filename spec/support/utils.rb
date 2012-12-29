def expose_methods(klass, *methods)
  klass.send(:public, *methods.flatten);
end

class String
  def capybara
    Capybara.string(self);
  end
end 

def icon_path(icon)
  "/assets/icons/#{icon}"
end

module RSpecExtensions

  # Didn't work
  # Problems with block calling, block.call runs outside 
  # context "within..", dunno why
  def within(selector, &block)
    parent_subject = subject || lambda { page }
    #puts "parent_subject = #{parent_subject.call.inspect}"
    context "within #{selector}" do
      subject(:container) { parent_subject.call.find(selector) }
      block.call
    end
  end

end