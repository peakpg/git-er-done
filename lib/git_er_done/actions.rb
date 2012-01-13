module Git
  module Er
    module Done
      module Actions
        
        # Run a git command.
        # This is basically a straight copy/paste from http://api.rubyonrails.org/classes/Rails/Generators/Actions.html#method-i-git
        # Avoids dragging in the entire rails stack for this one command.
        def git(command={})
          if command.is_a?(Symbol)
            run "git #{command}"
          else
            command.each do |cmd, options|
              run "git #{cmd} #{options}"
            end
          end
        end
      end
    end
  end
end
