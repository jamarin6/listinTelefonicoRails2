source 'https://rubygems.org'

ruby '2.1.5'

gem 'rails', '3.2.16'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3' ##
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
# To use Bootstrap ##
gem 'bootstrap-sass', '3.1.1.0' ##
gem "font-awesome-rails"

# Pagination
gem 'kaminari'
gem 'kaminari-bootstrap'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger', '~> 1.6.8'

group :development, :test do

 gem 'annotate'  # annotate, annotate --delete
 gem "rails-erd"     #gema para sacar diagramas de clases del modelo: rake erd
 gem 'better_errors' #gema para mostrar errores en desarrollo
 gem 'rails_best_practices'     # gema para control de calidad del codigo: bundle exec rails_best_practices .
 gem "letter_opener" #gema para visualizar mails
 gem 'byebug'
 
 gem 'xray-rails'

 gem 'bullet'
end