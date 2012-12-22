module GlobalHelper
  
  def insert_classes(attributes, *classes)
    attributes.html_merge(class: classes.flatten);
  end
  
end

[ApplicationHelper, ActionView::Base, ActiveRecord::Base, ActionController::Base].each do |klass|
  klass.send(:include, GlobalHelper);
end