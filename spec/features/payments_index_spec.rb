require 'rails_helper'

RSpec.feature 'Categories index', type: :feature do
  let(:user) { User.create!(name: 'Test', email: 'testing@gmail.com', password: 'f4k3p455w0rd') }

  before(:each) do
    login_as(user, scope: :user)
    @category1 = Category.create!(name: 'Example Category 1', user:) do |category|
      category.icon.attach(io: Tempfile.new(['example_image', '.png']), filename: 'example_image.png',
                           content_type: 'image/png')
    end
    @transaction1 = Payment.create!(name: 'Example transaction 1', amount: 24, author: user, category: @category1)
    @transaction2 = Payment.create!(name: 'Example transaction 2', amount: 50, author: user, category: @category1)
    visit category_payments_path(@category1)
  end
  after(:each) do
    user.destroy if user.persisted?
  end

  scenario 'display Transaction names' do
    expect(page).to have_content('Example transaction 1').and have_content('Example transaction 2')
  end

  scenario 'display total amount of transactions in category' do
    expect(page).to have_content('$74.00')
  end

  scenario 'display transaction amount' do
    expect(page).to have_content('24').and have_content('50')
  end
end
