# spec/models/payment_spec.rb

require 'rails_helper'

RSpec.describe Payment, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  after(:each) do
    user.destroy if user.persisted?
  end
  it 'is valid with valid attributes' do
    category = Category.create(name: 'Example Category', user:)
    payment = Payment.new(name: 'Example Payment', amount: 100.00, author: user, category:)

    expect(payment).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.create(name: 'Example Category', user:)
    payment = Payment.new(amount: 100.00, author: user, category:)
    expect(payment).not_to be_valid
    expect(payment.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without an amount' do
    category = Category.create(name: 'Example Category', user:)
    payment = Payment.new(name: 'Example Payment', author: user, category:)

    expect(payment).not_to be_valid
    expect(payment.errors[:amount]).to include("can't be blank")
  end

  it 'is not valid without an author' do
    category = Category.create(name: 'Example Category', user:)
    payment = Payment.new(name: 'Example Payment', amount: 100.00, category:)

    expect(payment).not_to be_valid
    expect(payment.errors[:author]).to include('must exist')
  end

  it 'is not valid without a category' do
    payment = Payment.new(name: 'Example Payment', amount: 100.00, author: user)

    expect(payment).not_to be_valid
    expect(payment.errors[:category]).to include('must exist')
  end
  describe 'associations' do
    it 'belongs to a user' do
      association = Payment.reflect_on_association(:author)
      expect(association.macro).to eq :belongs_to
    end
    it 'belongs to a category' do
      association = Payment.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end
  end
end
