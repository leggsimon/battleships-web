require 'spec_helper'

feature 'Starting a new game' do
  scenario 'Starting a new game' do
    visit '/'
    click_link 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'Enter name details into form. Reports hello' do
    visit '/name'
    fill_in('name', with: 'John')
    click_button('Submit')
    expect(page).to have_content('John')
  end

  scenario 'If no name is entered you are given link back to enter your name' do
    visit '/name'
    click_button('Submit')
    expect(current_url).to have_content('/name')
  end

  scenario 'Displays board when you start a game' do
    go_to_welcome_page
    click_button("Start Game")
    expect(page).to have_content('ABCDEFGHIJ')
  end

  scenario 'Can place a ship' do
    go_to_welcome_page
    click_button("Start Game")
    fill_in('Coordinates', with: 'C3')
    select "Destroyer", from: "shipTypes"
    select "Vertically", from: "orientation"
    click_button"Place Ship"
    expect(page).to have_content("ABCDEFGHIJ ------------ 1| |1 2| |2 3| D |3 4| D |4 5| |5 6| |6 7| |7 8| |8 9| |9 10| |10 ------------ ABCDEFGHIJ")
  end

  def go_to_welcome_page
    visit '/name'
    fill_in('name', with: 'Bob')
    click_button('Submit')
  end

end
