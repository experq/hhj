
def check_view_values(container, table)
  table.hashes.each do |row|
    container.find(".label:contains('#{row[:label]}') + span").should have_content row[:value]
  end
end

def check_details(details_selector, title, description, table)
  page.wait_until(5){ page.first details_selector } # CI tests fail randomly if we won't wait enough here
  details = page.find details_selector
  details.find("h2").should have_content title
  if not description.nil? and not table.nil?
    details.should have_content description
    check_view_values details, table
  end
end

def check_that_contains_values(container_selector, *values)
  values.each{ |value| find(container_selector).should have_content value }
end

Then %r/^I should see dialog '([^']*)':$/ do |title, table|
  content = find(".modal .content")
  content.find("h2:contains('#{title}')")
  check_view_values content, table
end
