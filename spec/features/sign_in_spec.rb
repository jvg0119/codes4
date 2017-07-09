require 'rails_helper'

feature "Signing in" do
  scenario "prompts for email and password" do
    visit(root_url)
    click_link("Sign In")
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_field("Email") # either style is OK
    expect(page).to have_field(:Password)
  #  save_and_open_page
  end

  scenario "signs in the user if he has valid email and password" do
    user = create(:user, name: "mike", email: "mike@example.com", password: "mypassword")
    visit(new_user_session_path)
    fill_in('Email', with: 'mike@example.com')
    fill_in('Password', with: 'mypassword')
    click_button('Log in')
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed in successfully.")
    #save_and_open_page
  end

  scenario "does not sign in user if he has an invalid email/or password" do
    user = create(:user, name: "mike", email: "mike@example.com", password: "mypassword")
    visit(new_user_session_path)
    fill_in('Email', with: 'tim@example.com')
    fill_in('Password', with: 'mypassword')
    click_button('Log in')
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content("Invalid Email or password.")
    #save_and_open_page
  end
end   # Signing in

feature "Signing out" do
  scenario "removes the user's current_user" do
    user = create(:user)
    login_as(user)
    visit(root_path)
    click_on("Sign Out")
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Signed out successfully.")
    #save_and_open_page
  end
end   # Signing out
