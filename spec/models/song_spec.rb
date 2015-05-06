require 'rails_helper'

RSpec.describe Song, type: :model do

  it "has a valid factory." do
    expect(FactoryGirl.create(:song)).to be_valid
  end

  it "is invalid without an iTunes ID." do
    expect(FactoryGirl.build(:song, itunes_id: nil)).to_not be_valid
  end

end
