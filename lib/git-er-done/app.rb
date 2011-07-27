require 'thor'
require 'rails/generators/actions'

module Git
  module Er
    module Done
      class App < Thor
        
        include Thor::Actions
        include Rails::Generators::Actions
        
        desc 'feature', 'Start a new feature as a git branch'
        def feature(name)
          puts 'Creating a new feature called #{name}.'
          git :checkout => "-b #{name}"
        end
          
          
      end
    end
  end
end
        
    