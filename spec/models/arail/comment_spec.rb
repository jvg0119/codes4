require 'rails_helper'

RSpec.describe Arail::Comment, type: :model do
  # let(:arail_createapp) { create(:arail_createapp) }
  # let(:arail_comment) { create(:arail_comment) }

  # let(:createapp) {Arail::Createapp.create!(title:"title", body:"body")}
  # let(:comment) {createapp.arail_comments.create!(body:"body")}

  it { is_expected.to belong_to(:arail_createapp) }

end
