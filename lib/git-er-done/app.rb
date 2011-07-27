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
        def done(name=nil)
          unless name
            name = current_feature            
          end
          puts "Completing a feature called #{feature_branch(name)}"
          git :add=>"."
          git :commit
          squash
          # Should we also sync with master first?
          git :checkout => 'master'
          git :merge => feature_branch(name)
          git :branch => "-d #{feature_branch(name)}"        
        end
        
        desc 'squash', 'Squash all commits from the current branch into a single commit.'
        def squash
          # Squash all changes since we branched away from master
          git :rebase => "-i master"
        end
        
        desc 'sync', 'Update your branch with the latest from master'
        def sync
          return_to_branch = current_branch
          git :checkout => :master
          git :pull
          git :checkout => return_to_branch
          git :rebase => :master
        end
        
        desc 'branch', 'Same as git branch.'
        # Exists mainly so I can test how Grit works.
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
        
        def current_feature
          b = current_branch
          if b.start_with?("features/")
            return b["features/".length, b.length]
          end
          return ""
        end
        
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
        
    