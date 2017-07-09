class Arail::Createapp < ApplicationRecord
  has_many :arail_comments, class_name: 'Arail::Comment', foreign_key: 'arail_createapp_id',  dependent: :destroy
  has_many :arail_images,  class_name: 'Arail::Image', foreign_key: 'arail_createapp_id', dependent: :destroy

  validates :title, :body, presence: true

  accepts_nested_attributes_for :arail_comments,
    reject_if: proc { |attributes| attributes[:body].blank? },
    allow_destroy: true

  accepts_nested_attributes_for :arail_images,
    reject_if: proc { |attributes| attributes[:content].blank? },
    allow_destroy: true

# over-ride to remove the extra 'arail' folder being added by Creatapp AR to find the view template
# w/o the over-ride Rails assume that I am using namespaces for the controllers also
  def to_partial_path
    'createapp'
  end

end
