class AddViewCount < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :click_count, :integer, default: 0
  end
end
