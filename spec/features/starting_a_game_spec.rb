require 'spec_helper'

feature 'Starting a new game' do 
  scenario 'Starting a new game' do 
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Enter name details into form' do
    visit '/new_game' do
      params={:name =>'Bob'}
    expect(form).to have_content "Bob"






end
