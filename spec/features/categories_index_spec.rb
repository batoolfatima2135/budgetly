require 'rails_helper'

RSpec.feature 'Categories index', type: :feature do
  let(:user) { User.create!(name: 'Test', email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @category1 = Category.create!(name: 'Example Category 1', user:) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png',
                           content_type: 'image/png')
    end
    @category2 = Category.create!(name: 'Example Category 2', user:) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png',
                           content_type: 'image/png')
    end
    @transaction1 = Payment.create!(name: 'Example transaction 1', amount: 24, author: user, category: @category1)
    @transaction2 = Payment.create!(name: 'Example transaction 2', amount: 50, author: user, category: @category1)
    @transaction3 = Payment.create!(name: 'Example transaction 3', amount: 30, author: user, category: @category2)
    visit categories_path
  end
  after(:each) do
    user.destroy if user.persisted?
  end
  scenario 'display category names' do
    expect(page).to have_content('Example Category 1').and have_content('Example Category 2')
  end

  scenario 'display category images and total amount and monthly budget' do
    expect(page).to have_css('img[src*="example_image.png"]', count: 2)
    expect(page).to have_content('$74.00').and have_content('$30.00').and have_content('$1000')
  end

  scenario 'click on category takes to transaction page of that category' do
    click_link(@category1.name)
    expect(page).to have_current_path(category_payments_path(@category1))
  end
end
