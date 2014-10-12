feature "Admin Navbar" do

  before(:each) do
    create_user({username: "admin", password: "password", first_name: "Ad", last_name: "Min", admin: true})
  end


  scenario "As an admin, my navbar should include admin-specific navigation tools" do

  end



end