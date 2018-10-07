require 'spec_helper'

RSpec.describe Beer, type: :model do
  describe "beer creation" do
    let(:brewery){ Brewery.create name:"Viikin pöhinä", year:2018 }
    
    it "succeeds with correct properties" do
      beer = Beer.create name:"Litku", style:"IPA", brewery: brewery
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end

    it "fails if style property is missing" do
      beer = Beer.create name:"Koff VI", brewery: brewery
      expect(beer).not_to be_valid
      expect(Beer.count).to eq(0)
    end

  end
end
