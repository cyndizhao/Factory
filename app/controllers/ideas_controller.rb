class IdeasController < ApplicationController
  before_action :get_idea, only:[:show, :update, :edit, :destroy]
  # before_action :idea_params, only:[:update, :create]
  before_action :authenticate_user!, except: [:show, :index]
  # def new
  #   @idea = Idea.new
  # end

  def index
    @ideas = Idea.last(10)
    @ideatest = Idea.new
  end

  def create
    # post_params = params.require(:post).permit([:title, :body, :category_id])
    @idea = Idea.new (idea_params)
    @idea.user = current_user
    if @idea.save
      flash[:notice] = "A New Idea Created Successfully!"
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def show
    @reviews = @idea.reviews
    @review = Review.new
    if !(@idea.likes.find_by_user_id(current_user))
      @liked_by_currentuser = false
    else
      @liked_by_currentuser = true
    end
    @like = Like.new

  end

  def destroy
    if !can? :destroy, @idea
      redirect_to idea_path(@idea), alert:'Access denied!'
    else
      @idea.destroy
      redirect_to root_path, notice:'Idea Deleted!'
    end
  end

  def edit
    # @idea = Idea.find(params[:id])
    redirect_to idea_path(@idea), alert:'Access denied!' unless can? :edit, @idea

  end

  def update

    # @post = Post.find(params[:id])
    # post_params = params.require(:post).permit([:title, :body, :category_id])
    if !can? :edit, @post
      redirect_to root_path, alert:'Access denied!'
    elsif @post.update(post_params)
      flash[:notice] = "Post Updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
  def get_idea
    @idea = Idea.find(params[:id])
  end

  def idea_params
    params.require(:idea).permit([:title, :body])
  end
  end
