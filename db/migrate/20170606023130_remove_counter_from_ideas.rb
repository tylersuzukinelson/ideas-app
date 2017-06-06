class RemoveCounterFromIdeas < ActiveRecord::Migration[5.1]
  def change
    remove_column :ideas, :counter, :integer
  end
end
