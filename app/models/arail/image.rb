class Arail::Image < ApplicationRecord
  belongs_to :arail_createapp, class_name: "Arail::Createapp", optional: true

  has_attached_file :content, styles: {
    xlarge: "1000x1000>", large: "600x600>", medium: "300x300>", small: "200x200>"},
    default_url: "/images/:style/missing.png"

  validates_attachment_content_type :content, content_type: /\Aimage\/.*\z/  # don't change image here

end
