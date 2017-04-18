require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
    # let(:review) {FactoryGirl.create(:review)}
  let(:idea) {FactoryGirl.create(:idea)}
  describe '#create' do
    context 'with no user sign in' do
      it 'redirects to the sign in page' do
        # post :create, params: {review: FactoryGirl.attributes_for(:review)}
        post :create, params: {
          idea_id: idea.id, review: FactoryGirl.attributes_for(:review)}
        expect(response).to redirect_to(new_session_path)
      end
    end

    context 'with user sign in' do
    before { request.session[:user_id] = user.id }
      context 'with valid attributes' do
        def valid_request
          post :create, params: {idea_id: idea.id, review: FactoryGirl.attributes_for(:review)}
        end
        it 'creates a new review in the database' do
          count_before = Review.count
          valid_request
          count_after = Review.count
          expect(count_after).to eq(count_before + 1)
        end

        it 'redirect to the idea show page' do
          valid_request
          expect(response).to redirect_to(idea_path(Idea.last))
        end

        it 'associates the created review with the signed in user' do
          valid_request
          expect(Review.last.user).to eq(user)
        end
      end
      context 'with invalid attributes' do
        def invalid_request
          post :create, params: {idea_id: idea.id, review: FactoryGirl.attributes_for(:review, body: nil)}
        end

        it 'desnt\'t create  record in the database' do
          count_before = Review.count
          invalid_request
          count_after = Review.count
          expect(count_before).to eq(count_after)
        end


        it 'renders the new template' do
          invalid_request
          expect(response).to redirect_to(idea_path(idea.id))
        end
      end
    end
  end
end
