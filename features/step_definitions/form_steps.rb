
def fillFieldByPlaceholder(form, placeholder, value)
  form.all("*[placeholder^=\"#{placeholder}\"]").select(&:visible?).map { |input| input.set(value) }.any?
end

def fillFieldByLabel(form, label, value)
  #form.all("label:contains('#{label}') ~ input").map { |input| input.set(value) }.any?
  form.all(:xpath, "//label[contains(.,'#{label}')]/following-sibling::input").map { |input| input.set(value) }.any?
end

def fillSelects(div, values)
  values.each_with_index do |value, index|
    selector = div.find("select:nth-child(#{index + 1})")
    #selector.find("option:contains('#{value}')").select_option
    selector.find(:xpath, "//option[contains(.,'#{value}')]").select_option
  end
end

def clickRadio(div, value)
  return false if value.nil? or div.nil?
  # div.find("label:contains('#{value}')").click
  div.find(:xpath, "//label[contains(.,'#{value}')]").click
end

def fillRadio(form, label, value)
  # clickRadio first("span:contains('#{label}') + .buttons"), value
  # clickRadio first("span + .buttons"), value
  clickRadio first(:xpath, "//span[contains(., '#{label}')]/following-sibling::*[1][@class='buttons']"), value
end

def fillSelectsWithRadio(form, label, value)
  selectValue, radioValue = value.split '+'
  # selectsDiv = form.first(".inline-block:contains('#{label}')")
  selectsDiv = form.first(:xpath, "//div[@class='inline-block' and contains(.,'#{label}')]")

  return false if selectsDiv.nil?
  fillSelects selectsDiv, selectValue.split('/')
  clickRadio selectsDiv.find(:xpath, './following-sibling::div[1]'), radioValue
  not selectsDiv.nil?
end

def fill_in_form (form, data)
  data.each do |row|
    next if fillFieldByPlaceholder form, row[:label], row[:value]
    next if fillFieldByLabel form, row[:label], row[:value]
    next if fillRadio form, row[:label], row[:value]
    next if fillSelectsWithRadio form, row[:label], row[:value]
    form.fill_in row[:label], with: row[:value]
  end
end

When %r/^I fill in form '([^']*)':$/ do |form_title, table|
  #form = find("*:contains('#{form_title}') ~ form")
  form = find(:xpath, "//*[contains(.,'#{form_title}')]/following-sibling::form")
  fill_in_form form, table.hashes
end


