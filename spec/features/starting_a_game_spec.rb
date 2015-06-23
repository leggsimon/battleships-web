require 'spec_helper'

feature 'Starting a new game' do
  scenario 'Starting a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Enter name details into form. Reports hello' do
    visit '/name'
    fill_in('name', with: 'Bob')
    click_button('Submit')
    expect(page).to have_content('Bob')
  end

  scenario 'If no name is entered you are given link back to enter your name' do
    visit '/name'
    click_button('Submit')
    click_link 'Please click here to enter your name'
    expect(current_url).to have_content('/name')
  end


end
