class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @idea = Idea.find(params[:idea_id])
    @like = Like.new
    @like.idea = @idea
    @like.user = current_user
    success = @like.save

    if success
      redirect_to idea_path(@idea), notice:'Liked'
    else
      render '/ideas/show'
    end
  end
end
