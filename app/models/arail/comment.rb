class Arail::Comment < ApplicationRecord
  belongs_to :arail_createapp, class_name: "Arail::Createapp", optional: true

end
