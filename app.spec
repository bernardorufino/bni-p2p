User
  should respond to #password
  should respond to #name
  should respond to #password_confirmation
  should respond to #email
  should respond to #remember_me
  when saving with upcased email
    email
      should == "bermonruf@gmail.com"
  validations
    when email is already taken with different capitalization
      should not be valid
    when password_confirmation is not present
      should not be valid
    when given invalid email user_at_foo.org
      should not be valid
    when name is not present
      should not be valid
    when email is already taken
      should not be valid
    when name is too long
      should not be valid
    when given valid email user@foo.COM
      should be valid
    when given valid email frst.lst@foo.jp
      should be valid
    when given invalid email user@foo,com
      should not be valid
    when given invalid email foo@bar+baz.com
      should not be valid
    when given valid email ab@baz.cn
      should be valid
    when email is not present
      should not be valid
    when password is too short
      should not be valid
    when valid
      should be valid
    when password_confirmation is nil
      should not be valid
    when given invalid email exemple.user@foo.
      should not be valid
    when given valid email US-ER@f.b.org
      should be valid
    when given invalid email foo@bar_baz.com
      should not be valid
    when password is not present
      should not be valid
    when password_confirmation doesn't match password
      should not be valid

ApplicationHelper
  #button_to
    when given path and content as string
      should have css "a.btn"
    when given path and content as block
      should have css "a.btn"
    when given path, content and extra class
      should have css "a.btn.extra-class"
  #nav
    should not have css "ul li.divider.nav-header"
    should have css "ul li a[href=\"/page\"]" with text "Page"
    should have css "ul li.active a[href=\"/page/home\"]" with text "Current"
    should have css "ul li.nav-header" with text "Header"
    should have css "ul li.nav-header.sample-class" with text "Header"
    should have css "ul li.divider.sample-class"
    should have css "ul li.sample-class.disabled.active a[href=\"/page/home\"]" with text "Current"
    should have css "ul li.disabled a[href=\"/disabled\"]" with text "Disabled"
    should have css "ul#foo.bar.nav"
    should have css "ul li#home a[href=\"/\"]" with text "Home"
    should have css "ul li.divider"
    should have css "ul li.sample-class span" with text "Generic"
    when tag ol is given
      should have css "ol"
    when calls are wrapped with 'with' method
      should have css "ul li.sample-class.sample-class2 span" with text "Generic"
      should have css "ul li.sample-class a[href=\"/page\"]" with text "Page"
    when nav is manually set to false
      should not have css "ul.nav"
    when nav is manually set to false and a class is given
      should not have css "ul.nav"
      should have css "ul.menu"
  #text_icon
    when given text "g_white_user" and icon "Usuario" with attributes {}
      should start with "g_white_user"
      should end with "<img alt=\"Usuario\" class=\"icon\" src=\"/images/icons/Usuario.png\" />"
    when given text "g_user" and icon "Usuario" with attributes {}
      should start with "g_user"
      should end with "<img alt=\"Usuario\" class=\"icon\" src=\"/images/icons/Usuario.png\" />"
    when given text "resultset_next" and icon "Play" with attributes {}
      should start with "resultset_next"
      should end with "<img alt=\"Play\" class=\"icon\" src=\"/images/icons/Play.png\" />"
    when given text "g_user" and icon "Usuario" with attributes {:id=>"id", :class=>"class"}
      should start with "g_user"
      should end with "<img alt=\"Usuario\" class=\"icon class\" id=\"id\" src=\"/images/icons/Usuario.png\" />"
    when given text "resultset_next" and icon "Play" with attributes {:id=>"id", :class=>"class", :width=>16, :height=>16}
      should start with "resultset_next"
      should end with "<img alt=\"Play\" class=\"icon class\" height=\"16\" id=\"id\" src=\"/images/icons/Play.png\" width=\"16\" />"
  #button
    when given content and extra class
      should have css "button.btn" with text "Sample"
      should have css ".extra-class"
    when given only content
      should have css "button.btn" with text "Sample"
    when given content and no type attribute
      should have css "button[type=\"button\"]"
    when given type and content
      should have css "button.btn" with text "Sample"
      should have css ".btn-primary" with text "Sample"
    when given content and type attribute
      should have css "button.btn" with text "Sample"
      should have css "button[type=\"submit\"]"
  #icon_text
    when given icon "g_white_user" and text "Usuario" with attributes {}
      should start with "<i class=\"icon-white icon-user\"></i>"
      should end with "Usuario"
    when given icon "g_user" and text "Usuario" with attributes {}
      should start with "<i class=\"icon-user\"></i>"
      should end with "Usuario"
    when given icon "resultset_next" and text "Play" with attributes {}
      should start with "<img alt=\"Resultset_next\" class=\"icon\" src=\"/images/icons/resultset_next.png\" />"
      should end with "Play"
    when given icon "g_user" and text "Usuario" with attributes {:id=>"id", :class=>"class"}
      should start with "<i class=\"icon-user class\" id=\"id\"></i>"
      should end with "Usuario"
    when given icon "resultset_next" and text "Play" with attributes {:id=>"id", :class=>"class", :width=>16, :height=>16}
      should start with "<img alt=\"Resultset_next\" class=\"icon class\" height=\"16\" id=\"id\" src=\"/images/icons/resultset_next.png\" width=\"16\" />"
      should end with "Play"
  #icon
    it should behave like icon
      should have css "img.icon"
      should == "/assets/icons/resultset_next.png"
    when size provided
      it should behave like icon
        should have css "img.icon"
        should == "31"
        should == "42"
        should == "/assets/icons/resultset_next.png"
    when given prefix g_ (glyphicon)
      should have css "i.icon-user"
      and attributes id and class
        should have css "i#id.icon-user.class"
    when given prefix g_white_ (white glyphicon)
      should have css "i.icon-user.icon-white"
  #flash_messages
    when flash[info] is assigned
      should have css ".alert" with text "message"
      should have css ".alert-info"
    when no flash is set
      should be empty
    when flash[alert] is assigned
      should have css ".alert" with text "message"
    when flash[success] is assigned
      should have css ".alert" with text "message"
      should have css ".alert-success"
    when flash error and info are assigned
      should have css ".alert.alert-error" with text "error"
      should have css ".alert.alert-info" with text "info"
    when flash[error] is assigned
      should have css ".alert" with text "message"
      should have css ".alert-error"
    when flash[notice] is assigned
      should mimic success output
      should not have css ".alert-notice"
  #title
    when view doesn't specify custom title'
      should == "BNI P2P"
    when view specifies custom title
      should match /custom/
      should match "BNI P2P"

Hash
  html_merge
    should include {:id=>"s2"}
    should not have key :class
    when given "sample-class1 class2" and ["sample-class3", "class4"]
      should not have repeated classes
      should have classes sample-class1, class2, sample-class3, class4
      should have 4 classes
    when given nil and "sample-class1"
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given nil and "sample-class1 class2"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given ["sample-class3", "class4"] and nil
      should not have repeated classes
      should have classes sample-class3, class4
      should have 2 classes
    when given "sample-class1" and "sample-class3 class4"
      should not have repeated classes
      should have classes sample-class1, sample-class3, class4
      should have 3 classes
    when given ["sample-class1", "class2"] and "sample-class1 class2"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given ["sample-class1", "class2"] and ["sample-class1", "class2"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given ["sample-class1"] and ["sample-class1", "class2"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1" and ["sample-class1"]
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given "sample-class1" and ["sample-class3", "class4"]
      should not have repeated classes
      should have classes sample-class1, sample-class3, class4
      should have 3 classes
    when given ["sample-class1"] and nil
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given "sample-class1" and "sample-class1"
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given ["sample-class1", "class2"] and nil
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given nil and ["sample-class1"]
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given ["sample-class1"] and "class2"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1" and ["sample-class1", "class2"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1 class2" and "sample-class1"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given ["sample-class1", "class2"] and ["sample-class3", "class4"]
      should not have repeated classes
      should have classes sample-class1, class2, sample-class3, class4
      should have 4 classes
    when given "sample-class1 class2" and nil
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1 class2" and ["sample-class1", "class2"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "class2" and ["sample-class1"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1" and nil
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given "sample-class1 class2" and "sample-class3 class4"
      should not have repeated classes
      should have classes sample-class1, class2, sample-class3, class4
      should have 4 classes
    when given ["sample-class1", "class2"] and "sample-class3 class4"
      should not have repeated classes
      should have classes sample-class1, class2, sample-class3, class4
      should have 4 classes
    when given "sample-class1" and "sample-class1"
      should not have repeated classes
      should have classes sample-class1
      should have 1 classes
    when given nil and ["sample-class1", "class2"]
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class3 class4" and "sample-class1"
      should not have repeated classes
      should have classes sample-class1, sample-class3, class4
      should have 3 classes
    when given ["sample-class1", "class2"] and "sample-class1"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given "sample-class1" and "class2"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes
    when given ["sample-class3", "class4"] and "sample-class1"
      should not have repeated classes
      should have classes sample-class1, sample-class3, class4
      should have 3 classes
    when given "sample-class1" and "sample-class1 class2"
      should not have repeated classes
      should have classes sample-class1, class2
      should have 2 classes

PagesController
  behaves like having page
    home
      should have css "html"