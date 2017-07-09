require 'rails_helper'

RSpec.describe Arail::Createapp, type: :model do
  let(:createapp) { create(:arail_createapp) }

  it "is valid with valid attributes" do
    expect(createapp).to be_valid
  end
  it "is invalid without a title" do
    # createapp = Arail::Createapp.new(title:"title", body:"body")
    createapp.title = nil
    expect(createapp).to be_invalid
  end
  it "is invalid without a body" do
    createapp.body = nil
    expect(createapp).to be_invalid
  end

  it { should accept_nested_attributes_for(:arail_comments) }

  it { should accept_nested_attributes_for(:arail_images) }

end
