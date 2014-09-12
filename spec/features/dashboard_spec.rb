feature "Dashboard Page" do
  before(:each) do
    @user1 = create_user({first_name: "Adam", username: "adam"})
    create_rant(1, {user_id: @user1.id})
    @user2 = create_user
    create_rant(2, {user_id: @user2.id})
    visit_login_page_and_fill_in_form('seth', 'password')
    click_on "Login"
  end

  scenario "As a user, I can link to edit my profile" do
    expect(page).to have_content "Seth Geyer"
    click_on "Seth Geyer"
    expect(page).to have_css("#edit-profile")
  end

  scenario "As a user, I can post my rants" do
    expect(page).to have_css(".rant-form")
  end


  scenario "As a user, I can view my rants" do
    expect(page).to have_css(".my-rants")
    expect(page.find(".my-rants")).to have_content("I've got rants in my pants #2")
  end

  scenario "As a user, I can view others rants" do
    expect(page.find(".others-rants")).to have_content("Adam")
    expect(page.find(".others-rants")).to have_link("Follow")
    expect(page.find(".others-rants")).to have_content("I've got rants in my pants #1")
    expect(page.find(".others-rants")).not_to have_content("I've got rants in my pants #2")

  end

  scenario "As a user, I can click on another user to follow them or 'unfollow' them" do
    expect(page.find(".others-rants")).to have_content("Adam")
    first('.other-details').click_link("Follow")
    expect(page.find(".others-rants")).to have_link("Unfollow")
    click_link("Unfollow")
    expect(page.find(".others-rants")).to have_link("Follow")

  end





end