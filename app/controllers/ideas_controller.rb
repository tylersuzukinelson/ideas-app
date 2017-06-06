class IdeasController < ApplicationController
  before_action :authorize, except: [:index, :show]
  before_action :idea

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def new
  end

  def create
    idea.user = current_user
    if idea.save
      redirect_to ideas_path, notice: "Idea created successfully"
    else
      flash[:alert] = "Please provide title"
      render :new
    end
  end

  def show
    @like = idea.like_for(current_user)
    @review = Review.new
    @reviews = idea.reviews.order(created_at: :desc)
  end

  def edit
  end

  def update
    if idea.update(idea_params)
      redirect_to idea, notice: "Idea Updated"
    else
      render :edit
    end
  end

  def destroy
    if idea.destroy
      redirect_to ideas_path
    else
      redirect_to ideas_path, alert: "It didn't work :("
    end
  end


  private

  def idea_params
    params.require(:idea).permit([:title, :description])
  end

  def idea
    @idea ||= begin
      if params[:id]
        Idea.find params[:id]
      elsif params.has_key? :idea
        Idea.new idea_params
      else
        Idea.new
      end
    end
  end
end
