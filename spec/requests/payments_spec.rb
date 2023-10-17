describe "/payments", type: :request do
 let(:user) { User.first }

 before(:each) do
  login_as(user, scope: :user)
  @file = Tempfile.new(['example_image', '.png'])
  @icon = fixture_file_upload(@file.path, 'image/png')
  @category = Category.new(name: 'Example Category', user: user)
  @category.icon.attach(@icon)
  @category.save
 
end

  describe "GET /index" do
    it "renders a successful response" do
      Payment.create!(name: "test", amount: 12, author: user, category: @category)
      get category_payments_url(@category)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_category_payment_path(@category)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Payment" do
        expect {
          post category_payments_url(@category), params: { payment: {name: 'test', amount: 12} }
        }.to change(Payment, :count).by(1)
      end

      it "redirects to the category page" do
        post category_payments_url(@category), params: { payment: {name: 'test', amount: 12}  }
        expect(response).to redirect_to(category_payments_url(@category))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Payment" do
        expect {
          post category_payments_url(@category), params: { payment: {name: 'test'}  }
        }.to change(Payment, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post category_payments_url(@category), params: { payment: {name: 'test'}  }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
