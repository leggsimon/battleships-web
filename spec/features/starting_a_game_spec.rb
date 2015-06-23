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

  context 'game on' do
    before(:each) do
      visit '/start?name=Faisal'
      click_button('Go')
    end

    scenario 'I can start by clicking go' do
      expect(page).to have_content "Please enter coordinate"
    end

    scenario 'I can fire at a ship' do
      fill_in('coordinate', with: 'G6')
      click_button('Fire!')
      expect(page).to have_content 'hit'
    end

    scenario 'I can fire more than once' do
      fill_in('coordinate', with: 'G6')
      click_button('Fire!')
      expect(page).to have_content 'Enter next Fire coordinate'
    end
  end


end
