require 'rails/generators/named_base'

module PrimerApi
  class InitializerGenerator < Rails::Generators::Base
    desc 'Create the initializer for Primer'
    def copy_initializer_file
      copy_file 'initializer.rb', 'config/initializers/primer_api.rb'
    end

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'initializer/templates')
    end
  end
end
