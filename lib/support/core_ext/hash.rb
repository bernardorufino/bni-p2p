class Hash

  def html_merge(attributes)
    attributes = attributes.dup;
    hash = insert_classes(self, extract_classes!(attributes));
    hash.merge(attributes);
  end
  
  def html_merge!(attributes)
    replace(html_merge(attributes));
  end
  
  protected
  def insert_classes(attributes, classes)
    classes += extract_classes!(attributes.dup);
    return attributes if classes.empty?;
    attributes.merge(class: classes.uniq.join(' '));  
  end
  
  def extract_classes!(attributes)
    [attributes.delete(:class) || []].flatten.map{|c| c.split(' ') }.flatten;
  end
  
end 