require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}

  describe '#new action' do
    context 'with no user sign in' do
      it 'redirect_to new_session template' do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user sign in' do
      before { request.session[:user_id] = user.id }
      it 'assigns a instance variable ' do
        get :new
        expect(assigns(:idea)).to be_a_new(Idea)
      end
      it 'renders the new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe '#create action' do
    before { request.session[:user_id] = user.id }
    context 'with valid attributes' do
      def valid_request
        post :create, params: {idea: FactoryGirl.attributes_for(:idea)}
      end
      it 'create a new instance for Idea in the database' do
        count_before = Idea.count
        valid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'set a flash message' do
        valid_request
        expect(flash[:notice]).to be
      end

      it 'redirect to the idea show page' do
        valid_request
        expect(response).to redirect_to(idea_path(Idea.last))
      end
    end

    context 'with invalid attributes' do
      def invalid_request
        post :create, params: {idea: FactoryGirl.attributes_for(:idea, title:nil)}
      end
      it 'does not create a new Idea in the database' do
        count_before = Idea.count
        invalid_request
        count_after = Idea.count
        expect(count_after).to eq(count_before)
      end

      it 'renders a new template' do
        invalid_request
        expect(response).to render_template(:new)
      end
    end

  end
end
