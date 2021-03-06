feature "Admin Rights" do

  before(:each) do
    @user = create_user_with_a_confirmed_email({first_name: "Seth", last_name: "Geyer"})
    @first_rant = create_rant(3, {topic: "first_rant_created", user_id: @user.id})
    @second_rant = create_rant(1, {topic: "second_rant_created", user_id: @user.id})
    @third_rant = create_rant(2, {topic: "third_rant_created", user_id: @user.id})
    @second_user = create_user_with_a_confirmed_email({first_name: "Steve", last_name: "Smith", username: "steve"})
    @fourth_rant = create_rant(4, {topic: "fourth_rant_created", user_id: @second_user.id})
    @third_user = create_user_with_a_confirmed_email({first_name: "Alex", last_name: "Firoved", username: "alex"})
    @fifth_rant = create_rant(5, {topic: "fifth_rant_created", user_id: @third_user.id})
    @sixth_rant = create_rant(6, {topic: "sixth_rant_created", user_id: @third_user.id})


  end


  scenario "As a non-admin, I can not access the 'admin's view' of rants" do
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    visit admin_rants_path
    expect(page).to have_content("Let It All Out")
  end


  scenario "As a non-admin, I can not access the 'admin's view' of users" do
    visit_login_page_and_fill_in_form("seth", "password")
    within("#new-sessions") {click_on "Login"}
    visit admin_users_path
    expect(page).to have_content("Let It All Out")
  end

  context "As a logged in admin" do
    before(:each) do
      create_admin_user
      visit_login_page_and_fill_in_form("admin", "password")
      within("#new-sessions") {click_on "Login"}
    end

    scenario "I can view a list of all rants in the system ordered by date" do
      click_on "Rants"
      expect(page).to have_content("third_rant_created")
      expect(page).to have_content("Seth Geyer")
    end

    scenario "I can view a list of all users and their total rants" do
      click_on "Users"
      expect(page).to have_content("Seth Geyer")
      expect(page).to have_content("3")
      expect(page).to have_content("Ad Min")
    end

    scenario "I can click to view an individual rant" do
      click_on "Rants"
      first(".viewer").click
      expect(page).to have_content("Alex Firoved")
      expect(page).to have_content("#{"d"*141}6")
    end



    scenario "I can disable a user from being able to login" do
      click_on "Users"
      first(".disable-link").click
      expect(User.find(@user.id).is_disabled).to eq(true)
      click_on "Logout"
      visit_login_page_and_fill_in_form("seth", "password")
      within("#new-sessions") {click_on "Login"}
      expect(page).to have_content("Your account has been disabled")
    end

    scenario "I can sort users by most rants submitted" do
      click_on "Users"
      find(".sorter").click
      within("tr.ranters-row:nth-child(1)") { expect(page).to have_content("Seth")}
      within("tr.ranters-row:nth-child(2)") { expect(page).to have_content("Alex")}
      within("tr.ranters-row:nth-child(3)") { expect(page).to have_content("Steve")}
      within("tr.ranters-row:nth-child(4)") { expect(page).to have_content("Ad")}

    end

    scenario "I can sort users by least rants submitted" do
      click_on "Users"
      find(".sorter").click
      find(".sorter").click
      within("tr.ranters-row:nth-child(1)") { expect(page).to have_content("Ad")}
      within("tr.ranters-row:nth-child(2)") { expect(page).to have_content("Steve")}
      within("tr.ranters-row:nth-child(3)") { expect(page).to have_content("Alex")}
      within("tr.ranters-row:nth-child(4)") { expect(page).to have_content("Seth")}
    end


    scenario "I can view all rants and view spam rants" do
      first_spam_rant = create_rant(7, {topic: "first_spam_rant_created", shown: false, user_id: @third_user.id})
      second_spam_rant = create_rant(8, {topic: "second_spam_rant_created", shown: false, user_id: @third_user.id})
      click_on "Rants"
      expect(page).to have_content("first_rant_created")
      expect(page).to have_content("first_spam_rant_created")
      expect(page).to have_content("second_spam_rant_created")
      click_on "All"
      expect(page).to have_content("first_rant_created")
      expect(page).to have_content("first_spam_rant_created")
      expect(page).to have_content("second_spam_rant_created")
      click_on "Spam"
      expect(page).not_to have_content("first_rant_created")
      expect(page).to have_content("first_spam_rant_created")
      expect(page).to have_content("second_spam_rant_created")
    end

    scenario "I can delete a rant identified as spam" do
      first_spam_rant = create_rant(7, {topic: "first_spam_rant_created", shown: false, user_id: @third_user.id})
      second_spam_rant = create_rant(8, {topic: "second_spam_rant_created", shown: false, user_id: @third_user.id})
      click_on "Rants"
      first("a.deleter").click
      expect(page).to have_content("first_rant_created")
      expect(page).to have_content("first_spam_rant_created")
      expect(page).not_to have_content("second_spam_rant_created")
    end

    scenario "I can reactivate a rant incorrectly identified as spam" do
      first_spam_rant = create_rant(7, {topic: "first_spam_rant_created", shown: false, user_id: @third_user.id})
      second_spam_rant = create_rant(8, {topic: "second_spam_rant_created", shown: false, user_id: @third_user.id})
      click_on "Rants"
      first("a.reactivator").click
      expect(page).to have_content("first_rant_created")
      expect(page).to have_content("first_spam_rant_created")
      expect(page).to have_content("second_spam_rant_created")
      click_on "Spam"
      expect(page).to have_content("first_spam_rant_created")
      expect(page).not_to have_content("second_spam_rant_created")
    end


  end






end