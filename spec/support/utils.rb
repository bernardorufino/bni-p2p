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