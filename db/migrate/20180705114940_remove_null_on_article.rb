class RemoveNullOnArticle < ActiveRecord::Migration[5.2]
  def change
    change_column_null :articles, :content, true
  end
end
