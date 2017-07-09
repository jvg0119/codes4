require 'rails_helper'

RSpec.describe Arail::Image, type: :model do
  it { is_expected.to belong_to(:arail_createapp) }
end
