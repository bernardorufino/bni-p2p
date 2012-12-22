class BNIP2P::Application
  
  # Include GlobalHelper
  require "#{config.root}/app/helpers/global_helper";
  
  # Core extensions
  Dir["#{config.root}/lib/support/core_ext/*.rb"].each {|f| require f }
  
  # Extend Sass
  # require "#{config.root}/app/assets/stylesheets/sass";
  
end
    