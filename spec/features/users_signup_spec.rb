require 'rails_helper'

RSpec.feature "UsersSignups", type: :feature do
  scenario "renders signup page" do
    visit signup_path
    expect(page).to have_http_status(200)
    expect(page).to have_selector('h1', text:'Sign up')
    expect(page).to have_selector('label', text:'Name')
    expect(page).to have_selector('input', id:'user_name')
    expect(page).to have_selector('label', text:'Email')
    expect(page).to have_selector('input', id:'user_email')
    expect(page).to have_selector('label', text:'Password')
    expect(page).to have_selector('input', id:'user_password')
    expect(page).to have_selector('label', text:'Confirm password')
    expect(page).to have_selector('input', id:'user_password_confirmation')
    expect(page).to have_button('Create account')


  end
end
