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

  scenario 'User can submit a new picture' do
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
    expect(page).to have_content 'Picture successfully created'
    expect(page.find('.picture_frame')['src']).to have_content 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png'
    expect(current_path).to eq (picture_path(Picture.where(description: 'Blue horse').first))
  end

  scenario 'Url field cannot be blank' do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'

    fill_in 'picture[url]', with: '            '
    fill_in 'picture[description]', with: 'Blue horse'
    fill_in 'picture[rating]', with: '3'
    click_on 'Create Picture'

    expect(Picture.find_by_description('Blue horse')).to eq nil

    expect(page).to have_content 'URL cannot be blank'
    within('textarea') do
      expect(page).to have_content 'Blue horse'
    end
  end

  scenario 'Description field cannot be blank' do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'

    fill_in 'picture[url]', with: 'http://youtube.com'
    fill_in 'picture[description]', with: ' '
    fill_in 'picture[rating]', with: '5'
    click_on 'Create Picture'

    expect(Picture.find_by_url('http://youtube.com')).to eq nil

    expect(page).to have_content 'Description cannot be blank'
    expect(page.find('#picture_url')['value']).to have_content 'http://youtube.com'
  end

  scenario 'user must submit a valid URL' do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'

    fill_in 'picture[url]', with: 'blah'
    fill_in 'picture[description]', with: 'blah blah'
    fill_in 'picture[rating]', with: '5'
    click_on 'Create Picture'

    expect(Picture.find_by_url('blah')).to eq nil

    expect(page).to have_content 'URL must be valid'
  end
  scenario 'Ratings must be a value from 0-5' do
    visit '/'
    click_on 'all pictures'
    click_on 'New Picture'

    fill_in 'picture[url]', with: 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png'
    fill_in 'picture[description]', with: 'Blue horse'
    fill_in 'picture[rating]', with: '100'
    click_on 'Create Picture'

    expect(page).to have_content 'Rating must be between 0 and 5'
  end

  scenario 'user can see all pictures and click on the picture to view the show page' do
    Picture.create(url: 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png', description: 'Blue horse', rating: 5)
    visit '/'
    click_on 'all pictures'
    expect(page.find('img')['src']).to have_content('http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png')
    find('.indexed_image').click
    expect(page).to have_content ('Blue horse')
  end

  scenario 'User can see an edit form with fields filled in' do
    picture = Picture.create(url: 'http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png', description: 'Blue horse', rating: 5)
    visit '/'
    click_on 'all pictures'
    expect(page.find('img')['src']).to have_content('http://versatileimages.com/wp-content/uploads/2014/04/gifthorse.png')
    find('.indexed_image').click
    click_link 'Edit'
    expect(page).to have_content 'Blue horse'
    expect(page.find('#picture_rating')['value']).to have_content 5
    expect(page.find('#picture_url')['value']).to have_content picture.url
  end
end