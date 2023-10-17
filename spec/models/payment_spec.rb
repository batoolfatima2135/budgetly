# spec/models/payment_spec.rb

require 'rails_helper'

RSpec.describe Payment, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(email: 'user@example.com', password: 'password')
    category = Category.create(name: 'Example Category', user: user)

    payment = Payment.new(name: 'Example Payment', amount: 100.00, author: user, category: category)
    
    expect(payment).to be_valid
  end

  it 'is not valid without a name' do
    user = User.create(email: 'user@example.com', password: 'password')
    category = Category.create(name: 'Example Category', user: user)

    payment = Payment.new(amount: 100.00, author: user, category: category)
    
    expect(payment).not_to be_valid
    expect(payment.errors[:name]).to include("can't be blank")
  end

  it 'is not valid without an amount' do
    user = User.create(email: 'user@example.com', password: 'password')
    category = Category.create(name: 'Example Category', user: user)

    payment = Payment.new(name: 'Example Payment', author: user, category: category)
    
    expect(payment).not_to be_valid
    expect(payment.errors[:amount]).to include("can't be blank")
  end

  it 'is not valid without an author' do
    user = User.create(email: 'user@example.com', password: 'password')
    category = Category.create(name: 'Example Category', user: user)

    payment = Payment.new(name: 'Example Payment', amount: 100.00, category: category)
    
    expect(payment).not_to be_valid
    expect(payment.errors[:author]).to include("must exist")
  end

  it 'is not valid without a category' do
    user = User.create(email: 'user@example.com', password: 'password')

    payment = Payment.new(name: 'Example Payment', amount: 100.00, author: user)
    
    expect(payment).not_to be_valid
    expect(payment.errors[:category]).to include("must exist")
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
