class CreateArailImages < ActiveRecord::Migration[5.1]
  def change
    create_table :arail_images do |t|
      t.string :title
      t.references :arail_createapp, foreign_key: true

      t.timestamps
    end
  end
end
