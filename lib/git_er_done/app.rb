require 'thor'
require 'grit'
require 'git_er_done/actions'

module Git
  module Er
    module Done
      class App < Thor

        include Thor::Actions
        include Git::Er::Done::Actions

        FEATURES_PATH = "features/"

        desc 'feature [NAME]', 'Start a new feature using a branch.'
        def feature(name)
          puts "Creating a new feature called #{feature_branch(name)}."
          git :checkout => "-b #{feature_branch(name)}"
        end

        desc 'inception', 'Find the branch(es) that the current branch was originally created from.'
        def inception
          # Find the first commit that matches one of the heads.
          matching_branches = inception_branches()

          if matching_branches.size > 1
            puts "Current branch '#{current_branch.name}' matches the following branches: '#{matching_branches.collect {|b| b.name}.join(", ")}'"
          else
            puts "Current branch '#{current_branch.name}' was forked from '#{matching_branches.first.name}'"
          end

        end

        # Add everything, commit it, merge it back into the main branch.
        desc 'done (NAME)', 'Completes a feature (commits, squashes then merges into master). Call sync before doing this.'
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
          new_commits = commits_in_feature_branch.size
          if new_commits < 2
            puts "Only '#{new_commits}' new commits in this branch, so no squashing necessary."
            return
          end
          # Squash all changes since we branched away from master
          git :rebase => "-i master"
        end

        desc 'info', "Report information about the current feature branch you are in."
        def info
          commits = commits_in_feature_branch
          puts "There are #{commits.size} new commits for #{current_branch_name}"
        end

        desc 'sync', 'Update your branch with the latest from master.'
        def sync
          return_to_branch = current_branch_name
          git :checkout => :master
          git :pull
          git :checkout => return_to_branch
          git :rebase => :master
        end

        desc 'version', 'Show the Git-Er-Done version and quit. (gd -v works too)'
        map "-v" => :version
        def version
          puts "Git-Er-Done #{Git::Er::Done::VERSION}"
        end

        private

        # Returns a list of branches that the current commit could have been originated from.
        # @return [Array<Grit::Head>]
        def inception_branches
          commit = current_branch.commit

          # Look through the parent history of this branch
          while true
            matching_branches = long_running_branches.select { |branch| commit.id == branch.commit.id }
            return matching_branches unless matching_branches.empty?
            commit = commit.parents.first
          end
          []
        end

        # Returns all branches that are 'long lived', i.e. not a feature.
        #
        # @return [Array<Grit::Head>]
        def long_running_branches
          repo.heads.select { |head| !head.name.include?('features') }
        end

        # Returns a list of all commits for the current branch since it was forked from master.
        def commits_in_feature_branch
          repo.commits_between(master_branch.name, current_branch.name)
        end

        # Returns the name of the feature for the current branch
        # @return [String] Name of feature (not include features/)
        def current_feature
          b = current_branch_name
          if b.start_with?(FEATURES_PATH)
            return b[FEATURES_PATH.length, b.length]
          end
          return ""
        end

        def current_branch
          repo.head
        end

        def current_branch_name
          current_branch.name
        end

        def repo
          repo ||= Grit::Repo.new('.')
        end

        def master_branch
          repo.heads.each do |head|
            return head if head.name == "master"
          end
          raise "No branch named 'master' found."
        end

        def feature_branch(name)
          "#{FEATURES_PATH}#{name}"
        end
      end
    end
  end
end
        
    