module Inheritance::ChildBehavior

  def self.included(klass)
    klass.extend ClassMethods;    
  end

  # Always call <parent-or-child>.child.save  
  module ClassMethods

    def is_one(parent, opts={})
      has_one(parent, {
        dependent: :destroy,
        autosave: true,
        validate: true, 
        as: Inheritance.interface(parent)
      }.merge(opts));
      eval_behavior(parent);
    end
     
    # Its on ::ParentBehavior
    def eval_behavior(parent)
      class_eval <<-EOS
        after_initialize { self.build_user unless user }
      EOS
    end
    
  end
  
  def child
    self
  end
  
  def child?
    true
  end
  
  def parent?
    false
  end

end