require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  describe "#new" do
    subject {get :new}

    context "with no user signed in" do
      it "redirects to the sign in page" do
        subject
        expect(response).to redirect_to(login_path)
      end
    end

    context "with user signed in" do
      before {request.session[:user_id] = user.id}

      it "assigns a product instance variable to be a new product" do
        subject
        expect(assigns(:idea)).to be_a_new(Idea)
      end

      it "renders the new template" do
        subject
        expect(response).to render_template(:new)
      end
    end

  end

  describe "#create" do
    subject {post :create, params: {idea: FactoryGirl.attributes_for(:idea)}}
    context "with no user signed in" do
      it "redirect to the sign in page" do
        subject
        expect(response).to(redirect_to(login_path))
      end
    end

    context "with signed in user" do
      before {request.session[:user_id] = user.id}

      context "with valid attribute" do
        it "creates a new idea" do
          expect{subject}.to change{Idea.count}.by(1)
          # or
          # expect{subject}.to change(Idea, :count).by(1)
        end

        it "redirects to the Ideas show page" do
          subject
          expect(response).to redirect_to(ideas_path)
        end

        it "sets a flash notice message" do
          subject
          expect(flash[:notice]).to eql "Idea created successfully"
        end

        it "associates the product to the user" do
          subject
          expect(Idea.last.user).to eq(user)
        end
      end
    end
  end
end
