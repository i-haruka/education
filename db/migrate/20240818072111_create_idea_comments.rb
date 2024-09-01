class CreateIdeaComments < ActiveRecord::Migration[6.1]
  def change
    create_table :idea_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
