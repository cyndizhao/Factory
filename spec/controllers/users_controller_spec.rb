require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#new' do
    it 'assigns a instance variable ' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'valid parameters' do
      def valid_request
        post :create, params: {user: FactoryGirl.attributes_for(:user)}
      end
      it 'create a new in the database' do
        count_before = User.count
        valid_request
        count_after = User.count
        expect(count_after).to eq(count_before + 1)
      end

      it 'redirects to the home page' do
        valid_request
        expect(response).to redirect_to(root_path)
      end

      it 'signs the user in' do
        valid_request
        user = User.last
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets a flash messages' do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context 'invalid parameters' do
      def invalid_request
        post :create, params: {user: FactoryGirl.attributes_for(:user, first_name:nil)}
      end
      it 'does not create a new user in the database' do
        count_before = User.count
        invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end

      it 'render back to the new template' do
        invalid_request
        expect(response).to render_template(:new)
      end

      it 'sets a flash messages' do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end

end
