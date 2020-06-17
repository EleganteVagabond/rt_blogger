class ConnectArticleAuthor < ActiveRecord::Migration[6.0]
  def change
    # add the reference
    add_reference :articles, :author, null: true, foreign_key: true
    # tie all articles to the default author (1)
    # Article.where(author_id: nil).update_all(author_id: 1)
    # Article.all.each do |article|
    #   article.author_id=1
    # end
    # modify the reference constraint to be non null with default 1
    # change_column_null :articles, :author, false
    change_column_null :articles, :author_id, false, 1
  end
end
