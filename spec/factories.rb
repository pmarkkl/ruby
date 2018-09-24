FactoryBot.define do
  factory :user do
    username { "petteri" }
    password { "Okei5" }
    password_confirmation { "Okei5" }
  end

  factory :brewery do
    name { "anonymous" }
    year { 1900 } 
  end

  factory :beer do
    name { "anonymous" }
    style { "Lager" } 
    brewery
  end

  factory :rating do
    beer
  end

end
