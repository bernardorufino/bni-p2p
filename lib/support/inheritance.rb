class Inheritance

  class << self  

    def interface(type)
      "#{type.to_s.underscore}_interface".to_sym
    end
    
    alias_method :child_of, :interface;
    
    def column_type(type)
      "#{interface(type)}_type".to_sym
    end
    
    def column_id(type)
      "#{interface(type)}_id".to_sym
    end
  
    def columns(type)
      [column_type(type), column_id(type)]
    end
  
  end

end