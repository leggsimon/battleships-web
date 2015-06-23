require 'spec_helper'

feature 'Starting a new game' do 
  scenario 'Starting a new game' do 
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Enter name details into form. Reports hello' do
    visit '/'
    click_link 'New Game'
    fill_in('name', with: 'Bob')
    click_button('Submit') 
    expect(page).to have_content('Bob')
  end






end
