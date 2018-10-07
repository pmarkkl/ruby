require 'spec_helper'

RSpec.describe User, type: :model do
  it "user without proper password not saved and validation fails" do
    user = User.create username:"petteri", password:"asdksd", password_confirmation:"asdksd"
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
  let(:user){ FactoryBot.create(:user) }
  let(:test_brewery){ FactoryBot.create(:brewery) }
  let(:test_beer){ Beer.create name:"Testi", style:"Porter" }
  let(:test2_beer){ Beer.create name:"Testikaks", style:"Lager" }
  describe "favorite style and brewery" do
    it "has a method for returning the favorite beer" do
      expect(user).to respond_to(:favorite_style)
    end
    it "returns the correct style" do
      rating = Rating.new score: 22, beer: test_beer
      rating2 = Rating.new score: 14, beer: test2_beer
      user.ratings << rating
      user.ratings << rating2
      expect(user.favorite_style).to eq("Porter")
    end
    it "has a method for returning favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end
    it "return the correct brewery" do
      brewery1 = Brewery.create name:"Testi1", year:2017
      brewery2 = Brewery.create name:"Testi2", year:2018
      bisse1 = Beer.new name:"Testikalja1", style:"Lager", brewery: brewery1
      bisse2 = Beer.new name:"Testikalja2", style:"Lager", brewery: brewery2
      rating = Rating.new score: 22, beer: bisse1
      rating2 = Rating.new score: 14, beer: bisse2
      user.ratings << rating
      user.ratings << rating2
      expect(user.favorite_brewery).to eq("Testi1")
    end
  end
end
