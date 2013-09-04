Given /^I am working on a git project$/ do
  steps %Q{
    Given I run `git init .`
    And an empty file named "README"
    And I run `git add README`
    And I run `git commit -m 'First commit'`
  }
end

Given /^I am working on the "(.*)" branch$/ do |branch|
  steps "Given I run `git checkout -b #{branch}`"
end
When /^should display the current version$/ do
  assert_partial_output(Git::Er::Done::VERSION, all_output)
end

When /^I commit a new file$/ do
  write_file('first.md', "A commit")
  run_simple "git add ."
  run_simple "git commit -m 'Add a file'"
end

When /^I commit another file$/ do
  write_file('second.md', "A commit")
  run_simple "git add ."
  run_simple "git commit -m 'Add a file'"
end

When /^I make several commits$/ do
  write_file('first.md', "A commit")
  run_simple "git add ."
  run_simple "git commit -m 'Add a file'"

  write_file('second.md', "A commit")
  run_simple "git add ."
  run_simple "git commit -m 'Add a file'"

end

When /^I have been working in the "([^"]*)" branch$/ do |branch_name|
  steps %Q{
      And I run `git checkout -b #{branch_name}`
  }
  write_file("#{branch_name}.md", "First commit for #{branch_name}")
  run_simple "git add ."
  run_simple "git commit -m 'First commit for #{branch_name}'"
end

Then /^the script should fail and exit$/ do
  # The exit code eally should be 1, but thor doesn't seem to respect error statuses
  # See http://stackoverflow.com/questions/17241932/ruby-thor-exit-status-in-case-of-an-error
  steps %Q{
      Then the exit status should be 0
      And the output should contain "Error!"
  }
end

Then /^the script should exit with a warning$/ do
  # The exit code eally should be 1, but thor doesn't seem to respect error statuses
  # See http://stackoverflow.com/questions/17241932/ruby-thor-exit-status-in-case-of-an-error
  steps %Q{
      Then the exit status should be 0
      And the output should contain "Warning!"
  }
end