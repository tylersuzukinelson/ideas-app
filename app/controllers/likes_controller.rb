class LikesController < ApplicationController
  before_action :authorize

  def create
    like = current_user.likes.new
    idea = Idea.find params[:idea_id]
    like.idea = idea
    if like.save
      redirect_to idea, notice: "Liked!"
    else
      redirect_to idea, alert: "Can't like!"
    end
  end
  def destroy
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to idea_path(like.idea), notice: "Unliked"
  end
end
