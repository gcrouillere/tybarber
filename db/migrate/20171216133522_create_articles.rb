class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :name, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
