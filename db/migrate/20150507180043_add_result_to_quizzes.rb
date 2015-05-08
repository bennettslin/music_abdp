class AddResultToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :result, :integer
  end
end
