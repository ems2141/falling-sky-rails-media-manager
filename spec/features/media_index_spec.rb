require 'spec_helper'

feature 'user goes to homepage' do
  scenario 'user can see Media Manager on the homepage' do
    visit '/'
    within('h1') do
      expect(page).to have_content('Media Manager')
    end
  end

  scenario 'user clicks all pix and see word "pictures" and path /pictures' do
    visit '/'
    click_on 'all pictures'
    expect(page).to have_content 'Pictures'
    expect(current_path).to eq (pictures_path)
  end

  scenario 'user clicks videos and see word "Videos and path /videos' do
    visit '/'
    click_link 'all videos'
    expect(current_path).to eq (videos_path)
  end
end



