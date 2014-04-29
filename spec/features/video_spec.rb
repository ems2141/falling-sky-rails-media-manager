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
end