class CreateArailComments < ActiveRecord::Migration[5.1]
  def change
    create_table :arail_comments do |t|
      t.text :body
      t.references :arail_createapp, foreign_key: true

      t.timestamps
    end
  end
end
