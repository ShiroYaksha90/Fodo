require 'rails_helper'

RSpec.feature 'Pages', type: :feature do
  scenario 'should display home page' do
    visit '/'
    expect(page).to have_selector('h1', text: 'Welcome to Foodo App')
    expect(page).to have_selector('h2', text: 'The best recipe app')
    expect(page).to have_selector('a', text: 'Sign up or Log in')
    expect(page).to have_link('Sign up or Log in', href: new_user_registration_path)
  end
end
