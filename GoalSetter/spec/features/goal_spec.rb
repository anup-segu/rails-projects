feature "the goal-making process" do
  before :each do
    create_georgia
    visit new_goal_url
  end

  it "has a new goal page" do
    expect(page).to have_content "Make a new goal"
  end

  feature "making a new goal" do
    it "redirects to new goal path" do
      sign_in_as_georgia
      visit new_goal_url
      make_tiramisu_goal
      expect(current_path).to eq('/goals/1')
      expect(page).to have_content("Eat Snacks")
    end
  end
end
