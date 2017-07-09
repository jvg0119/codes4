class AddSizeToArailImages < ActiveRecord::Migration[5.1]
  def change
    add_column :arail_images, :size, :string
  end
end
