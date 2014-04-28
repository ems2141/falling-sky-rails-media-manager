require 'spec_helper'

feature 'user goes to homepage' do
  scenario 'user can see Media Manager on the homepage' do
    visit '/'
    within('h1') do
      expect(page).to have_content('Media Manager')
    end
  end
end