module Inheritance::ParentBehavior
  
  def self.included(klass)
    klass.extend ClassMethods;
  end
  
  # Always call <parent-or-child>.child.save  
  module ClassMethods
    
    def acts_as_parent(opts={})
      belongs_to(Inheritance.interface(self), {
        polymorphic: true,
        #dependent: :destroy,
        #autosave: true,
        touch: true,
        #validate: true
      }.merge(opts));
    end
    
    def parent_of(*children)
      interface = Inheritance.interface(self);
      opts = (children.last.is_a?(Hash)) ? children.pop : {};
      acts_as_parent(opts);
      eval_behavior(interface, children);
    end
    
    def eval_behavior(interface, children)
      class_eval <<-EOS
        def #{self.to_s.underscore}; self; end
        alias_method :child, :#{interface}
        alias_method :child=, :#{interface}=
      EOS
      children.each do |child|
        class_eval <<-EOS
          def #{child}; (#{child}?) ? child : nil; end
          def #{child}?; #{interface}.is_a?(#{child.to_s.camelcase}); end
        EOS
        children.each do |current_child|
          child_return = (child == current_child) ? "child" : "nil";
          current_child.to_s.camelcase.constantize.send :class_eval, <<-EOS
            def #{child}; #{child_return}; end
            def #{child}?; #{child == current_child}; end
          EOS
        end # end inner children.each
      end # end children.each
    end # end #eval_behavior
    
  end
  
  def parent?
    true
  end
  
  def child
    false
  end
  
end