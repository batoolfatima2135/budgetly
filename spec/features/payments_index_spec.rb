require 'rails_helper'

RSpec.feature 'Categories index', type: :feature do
  let(:user) { User.create!(name: "Test", email: 'testing@gmail.com', password: 'f4k3p455w0rd') }
 
  before(:each) do
    login_as(user, scope: :user)
    @category1 = Category.create!(name: 'Example Category 1', user: user) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png', content_type: 'image/png')
    end
    @category2 = Category.create!(name: 'Example Category 2', user: user) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png', content_type: 'image/png')
    end
    @transaction1 = Payment.create!(name: 'Example transaction 1', amount: 24, author: user, category:@category1)
    @transaction2 = Payment.create!(name: 'Example transaction 2', amount: 50, author: user, category:@category1)
    @transaction3 = Payment.create!(name: 'Example transaction 3', amount: 30, author: user, category:@category2)
    @transaction4 = Payment.create!(name: 'Example transaction 4', amount: 20, author: user, category:@category2)
    
  end
  after(:each) do
    user.payments.destroy_all
    user.categories.destroy_all
    user.destroy if user.persisted?
  end

  scenario 'display Transaction names' do
    visit category_payments_path(@category1)
    expect(page).to have_content('Example transaction 1')
    expect(page).to have_content('Example transaction 2')

    visit category_payments_path(@category2)
    expect(page).to have_content('Example transaction 3')
    expect(page).to have_content('Example transaction 4')
  end

  
  scenario 'display total amount of transactions in category' do
    visit category_payments_path(@category1)
    expect(page).to have_content('$74.00')
    visit category_payments_path(@category2)
    expect(page).to have_content('$50.00')
  end

  scenario 'display transaction amount' do
    visit category_payments_path(@category1)
    expect(page).to have_content('24')
    expect(page).to have_content('50')
    visit category_payments_path(@category2)
    expect(page).to have_content('30')
    expect(page).to have_content('20')
  end


end