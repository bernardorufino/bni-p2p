# Use this file to rename your application
# Usage in command line: ruby rename.rb <NewName>
# or if you are running into trouble infering your app name
# use ruby rename.rb <OldName> <NewName>

if ARGV.size < 1
  raise ArgumentError, "Usage: ruby rename.rb <NewName>"
end

require 'fileutils'

# The file used for infering the app name
FILE = 'config/environment.rb';

def gsub_file(path, regexp, *args, &block)
  content = File.read(path).gsub(regexp, *args, &block);
  File.open(path, 'wb') {|f| f.write(content) }
end

def rename(file, opts)
  regexp, subst = *opts.to_a.first;
  gsub_file(file, regexp, subst);
  print ".";
end

def current_name
  File.read(FILE).match(/^(\w+?)::Application/) do |m|
    return m[1];
  end
end

if ARGV.size == 1
  old_name = current_name;
  new_name = ARGV[0];
else
  old_name, new_name = *ARGV[0..2];
end

name = Regexp.escape(old_name);
application_gsub = {/#{name}::Application/mi => "#{new_name}::Application"};

puts "Renaming to #{new_name}"

rename 'app/views/layouts/application.html.erb',   /#{name}/mi => new_name
rename 'config/application.rb',                    /module #{name}/mi => "module #{new_name}" 
rename 'config/environment.rb',                    application_gsub
rename 'config/routes.rb',                         application_gsub
rename 'config.ru',                                application_gsub
rename 'config/initializers/secret_token.rb',      application_gsub
rename 'config/initializers/session_store.rb',     application_gsub
rename 'config/initializers/load_libs.rb',         application_gsub
rename 'Rakefile',                                 application_gsub
rename 'config/environments/development.rb',       application_gsub
rename 'config/environments/test.rb',              application_gsub
rename 'config/environments/production.rb',        application_gsub

puts "\nDone"