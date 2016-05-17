require 'spec_helper'
require 'rails_helper'

feature "the signup process" do
  before :each do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  feature "signing up a user" do

    it "shows username on the homepage after signup" do
      sign_up("georgia")
      expect(page).to have_content("georgia")
      expect(current_path).to eq('/goals')
    end

  end

end

feature "logging in" do
  before :each do
    create_georgia
  end

  it "shows username on the homepage after login" do
    sign_in_as_georgia
    expect(page).to have_content("Georgia")
    expect(current_path).to eq('/goals')
  end
end

feature "logging out" do
  before :each do
    create_georgia
  end

  it "begins with logged out state" do
    visit goals_url
    expect(page).to have_content('Sign In')
    expect(page).to_not have_content('Sign Out')
  end

  it "doesn't show username on the homepage after logout" do
    sign_in_as_georgia
    click_button('Sign Out')
    expect(page).to_not have_content('Georgia')
  end

end
