# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(email: 'user@example.com', password: 'password') }
  after(:each) do
    user.destroy if user.persisted?
  end
  describe 'validations' do
    it 'is valid with valid attributes' do
      file = Tempfile.new(['example_image', '.png'])
      icon = fixture_file_upload(file.path, 'image/png')
      category = Category.new(name: 'Example Category', user:)
      category.icon.attach(icon)

      expect(category.icon).to be_attached
      expect(category).to be_valid
      user.destroy if user.persisted?
    end

    it 'is not valid without a name' do
      category = Category.new(user:)
      expect(category).to_not be_valid
    end

    it 'is not valid without an icon' do
      category = Category.new(name: 'Example Category', user:)
      expect(category).to_not be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      association = Category.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many payments' do
      association = Category.reflect_on_association(:payments)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'attachments' do
    it 'has one attached icon' do
      category = Category.new
      expect(category.icon).to be_an_instance_of(ActiveStorage::Attached::One)
    end
  end
end
