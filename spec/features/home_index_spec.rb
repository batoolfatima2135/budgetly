require 'rails_helper'

RSpec.feature 'home index', type: :feature do
  before(:each) do
    visit '/'
  end

  scenario 'display login and sigup button and logo' do
    expect(page).to have_link('LOG IN')
    expect(page).to have_link('SIGN UP')
    expect(page).to have_selector('img[alt="logo"]')
  end

  scenario 'login button takes to login page' do
    click_link('LOG IN')
    expect(page).to have_current_path(new_user_session_path)
  end

  scenario 'signup button takes to registor page' do
    click_link('SIGN UP')
    expect(page).to have_current_path(new_user_registration_path)
  end
end
