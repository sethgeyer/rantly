feature "search rants" do
  before(:each) do
    @steve = create_user_with_a_confirmed_email({first_name: "Steve", username: "steve", last_name: "Smith"})
    @steve_rant1 = create_rant(1, {user_id: @steve.id, created_at: "2014-10-09 19:02:39"})
    @steve_rant3 = create_rant(3, {user_id: @steve.id, created_at: "2014-10-15 19:00:42"})
    @stevey = create_user_with_a_confirmed_email({first_name: "Steve", username: "stevey", last_name: "Geyer"})
    @stevey_rant4 = create_rant(4, {user_id: @stevey.id})
    @seth = create_user_with_a_confirmed_email
    @seth_rant2 = create_rant(2, {user_id: @seth.id, created_at: "2014-10-16 19:00:42" })
    create_admin_user
    visit_login_page_and_fill_in_form('admin', 'password')
    within("#new-sessions") {click_on "Login"}
  end


  scenario "As a user if I fill in both date fields I get all rants back w/in the range of time" do
    visit admin_rants_path
    fill_in "begin_date", with: "10/09/2014"
    fill_in "end_date", with: "10/16/2014"
    click_on "Filter"
    expect(page).to have_content(@steve_rant1.topic)
    expect(page).to have_content(@steve_rant3.topic)
    expect(page).to have_content(@seth_rant2.topic)
  end

  scenario "As a user if I fill in both date fields I get all rants back w/in the range of time" do
    visit admin_rants_path

    fill_in "begin_date", with: "10/10/2014"
    fill_in "end_date", with: "10/16/2014"
    click_on "Filter"
    expect(page).not_to have_content(@steve_rant1.topic)
    expect(page).to have_content(@steve_rant3.topic)
    expect(page).to have_content(@seth_rant2.topic)
  end


end