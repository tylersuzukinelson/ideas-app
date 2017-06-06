require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  describe "#new" do

    context "with no user signed in" do
      it "redirects to the sign in page" do
        get :new
        expect(response).to(redirect_to(login_path))
      end
    end

    context "with user signed in" do
      before {request.session[:user_id] = user.id}

      it "assigns a product instance variable to be a new product" do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end

      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

  end

  describe "#create" do
    context "with no user signed in" do
      it "redirect to the sign in page" do
        post :create
        expect(response).to(redirect_to(login_path))
      end
    end

    context "with signed in user" do
      before {request.session[:user_id] = user.id}

    context "with valid attribute" do
      def valid_request
        attributes = FactoryGirl.attributes_for(:idea)
        post :create, params: { idea: attributes }
      end
        it "creates a new idea" do
        expect {valid_request}.to change {Idea.count}.by(1)
      end
      it "creates a new Idea part 2" do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before + 1)
      end
      it "redirects to the Ideas show page" do
        valid_request
        expect(response).to redirect_to(ideas_path)
      end
      it "sets a flash notice message" do
        valid_request
        expect(flash[:notice]).to be
      end
      it "associates the product to the user" do
        valid_request
        expect(Idea.last.user).to eq(user)
      end

    end
  end

  end

end
