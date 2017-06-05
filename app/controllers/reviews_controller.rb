class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: [:destroy]
  def create
    @idea = Idea.find params[:idea_id]
    # answer_params = params.require(:answer).permit(:body)
    @review = Review.new review_params
    @review.idea = @idea
    if @review.save
      redirect_to idea_path(@idea), notice: "Review Created"

    else
      render 'ideas/show'
    end
  end

  def destroy
    # @review = Review.find params[:id]

    @idea = @review.idea # or
    # @idea = Idea.find params[:idea_id]
    @review.destroy

    redirect_to idea_path(@idea), notice: 'Review Deleted!'
  end

  private

  def find_review
    @review = Review.find(params[:id])
  end
  def review_params
    params.require(:review).permit(:body)
  end
end
