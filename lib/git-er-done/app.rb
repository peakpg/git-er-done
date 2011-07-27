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
          puts "Creating a new feature called #{feature_branch(name)}."
          git :checkout => "-b #{feature_branch(name)}"
        end
          
        # Add everything, commit it, merge it back into the main branch.
        desc 'done', 'Completes a feature'
        def done(name)
          puts "Completing a feature called #{feature_branch(name)}"
          git :add=>"."
          git :commit
          git :checkout => 'master'
          git :merge => feature_branch(name)
          git :branch => "-d #{feature_branch(name)}"        
        end
        
        private
        
        def feature_branch(name)  
          "features/#{name}"
        end
      end
    end
  end
end
        
    