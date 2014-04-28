require 'spec_helper'

feature 'user can create pictures' do
  scenario 'user sees new form on pictures/new' do
    visit '/'
    click_on 'All Pictures'
    click_on 'New Picture'
    expect(current_path).to eq (pictures_new_path)
    expect(page).to have_content('URL of Photo')
    expect(page).to have_content('Short Description')
    expect(page).to have_content('Rating')
  end
end