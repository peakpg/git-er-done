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