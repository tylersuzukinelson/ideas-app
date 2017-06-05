class IdeasController < ApplicationController
  # before_action :authorize, only: [:edit, :update, :destroy, :create]
  before_action :authorize, except: [:index, :show]
  before_action :find_idea, only: [:show, :destroy, :edit, :update]
  def index
    @ideas = Idea.recent(30)
  end

  def new
    @idea = Idea.new
  end
  def create
    # post_params = params.require(:post).permit([:title, :content])
    @idea = Idea.new(idea_params)

    if @idea.save
      redirect_to @idea, notice: "Idea created successfully"
    else
      flash[:alert] = "Please provide title"
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @idea.reviews.order(:created_at :DESC)
    # @idea = Idea.find params[:id]
  end

  def destroy
    # @idea = Idea.find params[:id]
    @idea.destroy
    redirect_to ideas_path
  end

  def edit
    # @idea = Idea.find params[:id]
    
  end

  def update
    # @idea = Idea.find params[:id]
    # idea_params = params.require(:idea).permit([:title, :content])
    if @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: "Idea Updated"
    else
      render :edit
    end

  end

  private

  def idea_params
    idea_params = params.require(:idea).permit([:title, :description])
  end

  def find_idea
    @idea = Idea.find params[:id]
  end

end
