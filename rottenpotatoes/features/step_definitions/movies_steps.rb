
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    if uncheck
      step "I uncheck \"ratings[#{rating}]\""
    else
      step "I check \"ratings[#{rating}]\""
    end
  end
end

Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  # fail "Unimplemented"
  rows = rows = page.all('#movies tr').size - 1
  rows.should == Movie.count
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_name, director_name|
  Movie.exists?(title: movie_name, director: director_name).should be_truthy
end