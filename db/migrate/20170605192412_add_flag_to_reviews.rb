class AddFlagToReviews < ActiveRecord::Migration[5.1]
  def change
    add_column :reviews, :review_flag, :boolean, default: false
  end
end
