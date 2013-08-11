Given /^the following movies exist:$/ do |table|
  table.hashes.each {|m| Movie.create!(m) }
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |title, director|
  Movie.find_by_title(title).director.should eq director
end
