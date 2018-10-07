require 'spec_helper'

include Helpers

describe "Beers" do

  before :each do
    user = User.create username:"salama", password:"Jeeee5", password_confirmation:"Jeeee5"
    sign_in(username:"salama", password:"Jeeee5")
  end

  it "adding a beer works with proper name" do
    FactoryBot.create(:brewery)
    visit new_beer_path
    fill_in('beer_name', with: 'Jouluolut 2022')
    expect{ click_button('Create Beer') }.to change{Beer.count}.by(1)
    save_and_open_page
  end
  it "doesn't add to db it invalid name" do
    visit new_beer_path
    fill_in('beer_name', with: "")
    expect{ click_button('Create Beer') }.not_to change{Beer.count}
  end
  it "shows a proper error message with invalid name" do
    visit new_beer_path
    fill_in('beer_name', with: "")
    click_button('Create Beer')
    expect(page).to have_content("Name can't be blank")
  end
end
