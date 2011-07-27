require 'thor'
require 'rails/generators/actions'
require 'grit'

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
        
        desc 'sync', 'Brings your current feature up to date with master'
        def sync
          c_branch = current_branch
          git :checkout => :master
          git :pull
          git :checkout => c_branch
          git :rebase => :master
        end
        
        desc 'branch', 'Same as git branch.'
        def branch
          head = repo.head
          repo.branches.each do |b|
            if head.name == b.name
              print "* "
            else
              print "  "
            end
            puts b.name
          end
          
        end
        
        private
        
        def current_branch
          repo.head.name
        end
        
        def repo
          repo ||= Grit::Repo.new('.')
        end
        
        def feature_branch(name)  
          "features/#{name}"
        end
      end
    end
  end
end
        
    