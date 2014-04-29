require 'spec_helper'

feature 'user can create pictures' do
  scenario 'user sees new form on pictures/new' do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'
    expect(current_path).to eq (new_picture_path)
    expect(page).to have_content('URL of Photo')
    expect(page).to have_content('Short Description')
    expect(page).to have_content('Rating')
  end

  scenario 'User can submit a new picture'do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'
    expect(current_path).to eq (new_picture_path)

    fill_in 'picture[url]', with: 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png'
    fill_in 'picture[description]', with: 'Blue horse'
    fill_in 'picture[rating]', with: '3'
    click_on 'Create Picture'

    expect(page).to have_content 'Blue horse'
    expect(page).to have_content '3'
    expect(page).to have_content  'Picture successfully created'
    expect(page.find('.picture_frame')['src']).to have_content 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png'
    expect(current_path).to eq (picture_path(Picture.where(description: 'Blue horse').first))


  end
end