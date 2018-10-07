require 'rails_helper'

include Helpers

describe "Ratings" do
  let(:user) { FactoryBot.create(:user) }

  it "lists ratings and total number of ratings" do
    FactoryBot.create(:rating, score: 24, user: user)
    FactoryBot.create(:rating, score: 14, user: user)
    visit ratings_path
    expect(page).to have_content "List of ratings"
    expect(page).to have_content "Number of ratings: 2"
  end
  it "profile page shows only user's ratings" do
    user2 = User.create username:"salama", password:"Jeeee5", password_confirmation:"Jeeee5"
    FactoryBot.create(:rating, score: 19, user: user)
    FactoryBot.create(:rating, score: 22, user: user)
    FactoryBot.create(:rating, score: 7, user: user2)
    visit user_path(user)
    expect(page).to have_content "Has 2 ratings"
    visit user_path(user2)
    expect(page).to have_content "Has 1 rating"
  end
  it "when user deletes a rating it's removed from db" do
    user = User.create username:"salama", password:"Jeeee5", password_confirmation:"Jeeee5"
    sign_in(username:"salama", password:"Jeeee5")
    FactoryBot.create(:rating, score: 50, user: user)
    FactoryBot.create(:rating, score: 40, user: user)
    expect(Rating.count).to eq(2)
    visit user_path(user)
    first(:link, "delete").click
    expect(Rating.count).to eq(1)
  end
  it "profile page shows favorite style and brewery" do
    FactoryBot.create(:rating, score: 50, user: user)
    FactoryBot.create(:rating, score: 40, user: user)
    visit user_path(user)
    expect(page).to have_content "Favorite style of beer is Lager"
    expect(page).to have_content "Has 2 ratings"
  end
end
