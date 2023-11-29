require 'rails_helper'
require 'helpers/users_helper_spec'
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
  scenario "renders signup page with errors" do
    visit signup_path
    click_button 'Create account'
    expect(page).to have_selector('h1', text:'Sign up')
    expect(page).to have_selector('div.alert.alert-danger.alert-dismissible', text:'Prevented this User from being saved')
    expect(page).to have_selector('h2.card-title.text-danger', text:'4 errors Prevented this User from being saved:')
    expect(page).to have_selector('li', text:"Name can't be blank")
    expect(page).to have_selector('li', text:"Email can't be blank")
    expect(page).to have_selector('li', text:"Email is invalid")
    expect(page).to have_selector('li', text:"Password can't be blank")
  end
  scenario "successfully creates a new user" do
    features_signup
    expect(page).to have_selector('div.alert.alert-success.alert-dismissible', text:'Welcome to the Foodo App!')
    expect(page).to have_selector('h1', text:"Foo's profile")
    expect(page).to have_selector('img.gravatar')
    expect(page).to have_selector('h4', text:"Foo's recipes")
  end
end
