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

  scenario 'I can start by clicking go' do
    visit '/start?name=Faisal'
    click_button('Go')
    expect(page).to have_content "Please enter coordinate"
  end

  scenario 'I can enter a coordinate' do
    visit '/game'
    fill_in('coordinate', with: 'C5')
  end
end
