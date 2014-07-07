require 'spec_helper'

feature "Hompage" do

  scenario "user can visit homepage" do
    visit "/"
      expect(page).to have_content("Contacts")
  end

  scenario "user can click login link to see forms" do
    visit "/"
    click_link "Login"
    expect(page).to have_content("Username Password")
  end

  scenario "user can log in and see Welcome, username" do
    visit "/"
    click_link "Login"
    click_button "Sign In"
    expect(page).to have_content("Welcome")
  end





end