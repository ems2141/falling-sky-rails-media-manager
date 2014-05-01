require 'spec_helper'

feature 'User can CRUD a video' do
  scenario 'User can create a video' do
    visit '/'
    click_on 'all videos'
    click_on 'New Video'
    fill_in 'video[url]', with: 'http://youtu.be/bgXPl3XM_NA'
    fill_in 'video[description]', with: 'Dancing Baby'
    fill_in 'video[rating]', with: '5'
    click_on 'Add Video'
    expect(page).to have_content 'Dancing Baby'
    expect(page).to have_content 'http://youtu.be/bgXPl3XM_NA'
    expect(page).to have_content '5'
    expect(page).to have_content 'Video successfully created'
    expect(current_path).to eq video_path(Video.where(description: 'Dancing Baby').first)
  end

  scenario 'user can view all videos, and click video link to show one' do
    Video.create(url: 'http://youtube.com', description: 'Youtube', rating: 5)
    visit '/'
    click_on 'all videos'
    click_on 'New Video'
    fill_in 'video[url]', with: 'http://youtu.be/bgXPl3XM_NA'
    fill_in 'video[description]', with: 'Dancing Baby'
    fill_in 'video[rating]', with: '5'
    click_on 'Add Video'
    click_on 'all videos'

    # test for all videos listed on videos index
    expect(page).to have_content('http://youtube.com')
    expect(page).to have_content('http://youtu.be/bgXPl3XM_NA')

    # User can click on the video url to show that video
    click_on 'http://youtu.be/bgXPl3XM_NA'
    expect(page).to have_content 'Dancing Baby'
    expect(page).to have_content 'http://youtu.be/bgXPl3XM_NA'
    expect(page).to have_content '5'
    expect(current_path).to eq video_path(Video.where(description: 'Dancing Baby').first)
  end


  scenario 'Url field cannot be blank' do
    visit '/'
    click_on 'all videos'
    click_on 'New Video'

    fill_in 'video[url]', with: '            '
    fill_in 'video[description]', with: 'Blue horse'
    fill_in 'video[rating]', with: '3'
    click_on 'Add Video'

    expect(page).to have_content 'URL cannot be blank'
  end

  scenario 'Url must be valid' do
    visit '/'
    click_on 'all videos'
    click_on 'New Video'

    fill_in 'video[url]', with: 'poop'
    fill_in 'video[description]', with: 'Blue horse'
    fill_in 'video[rating]', with: '3'
    click_on 'Add Video'

    expect(Video.find_by_url('poop')).to eq nil

    expect(page).to have_content 'URL must be valid'
  end

  scenario 'Ratings must be a value from 0-5' do
    visit '/'
    click_on 'all videos'
    click_on 'New Video'

    fill_in 'video[url]', with: 'poop'
    fill_in 'video[description]', with: 'Blue horse'
    fill_in 'video[rating]', with: '100'
    click_on 'Add Video'

    expect(page).to have_content 'Rating must be between 0 and 5'
  end

  scenario 'Description cannot be blank' do
    visit '/'
    click_on 'all videos'
    click_on 'New Video'

    fill_in 'video[url]', with: 'http://youtu.be/bgXPl3XM_NA'
    fill_in 'video[description]', with: ''
    fill_in 'video[rating]', with: '3'
    click_on 'Add Video'

    expect(page).to have_content 'Description cannot be blank'

  end

  scenario 'User can edit a video by clicking edit from the show page' do
    Video.create(url: 'http://youtu.be/bgXPl3XM_NA', description: 'Youtube', rating: 5)
    visit '/'
    click_on 'all videos'
    click_on 'http://youtu.be/bgXPl3XM_NA'
    click_on 'Edit'

    fill_in 'video[rating]', with: '4'
    click_on 'Edit Video'
    expect(page).to have_content '4'
  end

  scenario 'User is given an error if rating is more than 5' do
      Video.create(url: 'http://youtu.be/bgXPl3XM_NA', description: 'Youtube', rating: 5)
      visit '/'
      click_on 'all videos'
      click_on 'http://youtu.be/bgXPl3XM_NA'
      click_on 'Edit'

      fill_in 'video[rating]', with: '45'
      click_on 'Edit Video'
      expect(page).to have_content 'Rating must be between 0 and 5'
  end
end