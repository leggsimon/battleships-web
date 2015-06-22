require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'I can enter my name' do
    visit '/start'
    fill_in('name',with: 'Player')
    click_button('Submit')
    expect(page).to have_content 'Hello Player, welcome to BattleshipsWeb'
  end


  scenario 'cannot leave field blank' do
    visit '/start'
    click_button('Submit')
    expect(page).to have_content "What's your name?"
  end
end
