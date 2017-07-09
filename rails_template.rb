# frozen_string_literal: true

require 'shellwords'

# rubocop:disable Metrics/MethodLength
def current_directory
  @current_directory ||=
    if __FILE__ =~ %r{\Ahttps?://}
      tempdir = Dir.mktmpdir('womany-chatbot-template')
      at_exit { FileUtils.remove_entry(tempdir) }
      git clone: [
        '--quiet',
        'https://github.com/5xRuby/womany-chatbot-template',
        tempdir
      ].map(&:shellescape).join(' ')

      tempdir
    else
      File.expand_path(File.dirname(__FILE__))
    end
end

def source_paths
  Array(super) + [current_directory]
end

gem 'facebook-messenger'
gem 'activeadmin', '~> 1.0.0'
gem 'devise'
gem 'dotenv-rails'

gem_group :development do
  gem 'pry-rails'
end

# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

after_bundle do
  generate 'devise:install'
  generate 'active_admin:install'

  insert_into_file 'config/application.rb', before: '  end' do
    <<-RUBY
    config.paths.add File.join('app', 'bot'), glob: File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'bot', '*')]
    RUBY
  end

  route 'mount Facebook::Messenger::Server, at: \'bot\''

  copy_file 'config/initializers/bot.rb'
  copy_file 'app/bot/message.rb'
  copy_file 'app/models/quick_reply.rb'
  copy_file 'lib/tasks/admin.rake'
  copy_file '.env'
end
