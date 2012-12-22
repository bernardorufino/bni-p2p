# Tested in ApplicationHelper#nav
class NavProxy 
  include GlobalHelper;
  CHILD_TAG = 'li';
  EMPTY_CONTENT = Proc.new { "" };

  def initialize(view_proxy, default_attributes={}, &block)
    @default_attributes = default_attributes;
    @current_page_test = block;
    @view_proxy = view_proxy;
    @html = "";
    reset_attributes;
  end
  
  def link_to(*args, &block)
    link_to(capture(&block), *args) if block_given?;
    content = args.shift;
    content = @view_proxy.link_to(content, *args, &block).html_safe;
    url = @view_proxy.url_for(args.shift);
    if current_page?(url)
      item(class: 'active') { content }
    else
      item { content }
    end
  end
  
  def item(attributes={}, &block)
    set_attributes(attributes);
    (block_given?) ? render_item(&block) : self;
  end
  
  def to_s
    render_item { "" }
  end
  
  def divider(attrs={})
    item(insert_classes(attrs, 'divider'));
  end
  
  def disabled(attrs={})
    item(insert_classes(attrs, 'disabled'));
  end
  
  def header(attrs={}, &block)
    item(insert_classes(attrs, 'nav-header'), &block);
  end
  
  def with(attrs, &block)
    defaults = @default_attributes;
    @default_attributes.html_merge!(attrs);
    html = capture(self, &block);
    @default_attributes = defaults;
    html.html_safe;
  end
  
  protected
  def capture(*args, &block)
    @view_proxy.capture(*args, &block);
  end
  
  def current_page?(page)
    @current_page_test.call(page);
  end
  
  def render_item(&block)
    content = capture(&block);
    @html = @view_proxy.content_tag(CHILD_TAG, content, @attributes);
    @html = "\t#{@html}".html_safe;
    reset_attributes;
    @html;
  end
  
  def set_attributes(attributes)
    @attributes = @attributes.html_merge(attributes);
  end
  
  def reset_attributes
    @attributes = @default_attributes;
  end

end