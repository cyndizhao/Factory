class ReviewsController < ApplicationController
  before_action :authenticate_user!

    def create
      @idea = Idea.find(params[:idea_id])
      review_params = params.require(:review).permit(:body)
      @review = Review.new(review_params)
      @review.idea = @idea
      @review.user = current_user
      success = @review.save

      if success

        redirect_to idea_path(@idea), notice:'Review Created'
      else
        redirect_to idea_path(@idea), alert:'Body must be provided!'
      end
    end

    def destroy
      @review = Review.find(params[:id])
      if !can? :destroy, @review
        redirect_to idea_path(params[:idea_id]), alert:'Access denied!'
      else
        @review.destroy
        redirect_to idea_path(params[:idea_id]), notice:'Review Deleted!'
      end
    end
end
