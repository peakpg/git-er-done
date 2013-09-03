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