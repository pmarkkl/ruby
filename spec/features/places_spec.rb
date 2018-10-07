require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end
  it "places are found all of them are listed" do
    visit places_path
    fill_in('city', with: 'Oulu')
    click_button "Search"
    page_results = page.all('td', text: 'Oulu')
    controller_results = BeermappingApi.places_in("Oulu")
    expect(page_results.length).to eq(controller_results.length)
  end
  it "shows a proper notification when places not found" do
    visit places_path
    fill_in('city', with: 'askdlsadkl')
    click_button "Search"
    save_and_open_page
    expect(page).to have_content "No locations in askdlsadkl"
  end
end
