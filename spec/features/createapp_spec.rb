require 'rails_helper'

describe "Createapp" do
  let(:editoruser) { create(:user, role: "editor") }
  let(:regularuser) { create(:user, role: "regular") }
  let(:createapp1) { create(:arail_createapp, title: "Createapp note title #1", body: "createapp body #1") }
  let(:createapp2) { create(:arail_createapp, title: "Createapp note title #2", body: "createapp body #2") }

  describe "with a signed editor user" do
    before { login_as(editoruser) }

    describe "viewing the index page of createapps" do
      it "shows the all creatapps" do
        createapp1; createapp2;
        visit(createapps_path)
        click_link("Rails")
        expect(current_path).to eq(createapps_path)
        click_link("Create App")
        expect(current_path).to eq(createapps_path)
        expect(page).to have_content(createapp1.title)
        expect(page).to have_content(createapp2.title)
      #  save_and_open_page
      end
      it "allows navigation to show createapp page by clicking on the createapp link" do
        createapp1
        visit(createapps_path)
        click_link(createapp1.title)
        expect(current_path).to eq(createapp_path(createapp1))
        expect(page).to have_content(createapp1.title)
      end
    end

    describe "viewing the show page createapp" do
      it "shows all the createapp's details" do
        visit(createapp_path(createapp1))
        expect(current_path).to eq(createapp_path(createapp1))
        expect(page).to have_content(createapp1.title)
        expect(page).to have_content(createapp1.body)
      end
      it "allows the navigation back to the index createapp" do
        visit(createapp_path(createapp1))
        click_link("Back to Creatapp list")
        expect(current_path).to eq(createapps_path)
        expect(page).to have_link(createapp1.title)
      end
    end

    describe "creation" do
      it "saves the createapp and redirects to its show page" do
        visit(createapps_path)
        click_link("Add new 'Create App note'")

        expect(current_path).to eq(new_createapp_path)
        fill_in('Title', with: 'My new title')
        fill_in('Body', with: 'my new body')

        click_button("Create Createapp")
        expect(current_path).to eq(createapp_path(Arail::Createapp.last))
        expect(page).to have_content("My new title")
      end
      it "does not save invalid createapps" do
        visit(createapps_path)
        click_link("Add new 'Create App note'")

        expect(current_path).to eq(new_createapp_path)
        fill_in('Title', with: '')
        fill_in('Body', with: 'my new body')

        click_button("Create Createapp")
        expect(current_path).to eq(createapps_path)
        expect(page).to have_content("There was an error saving your 'createapp' note. Please try again.")
      end
      it "allows you to cancel the creation of a 'New Createapp Note'" do
        visit(new_createapp_path)
        click_link("Cancel")
        expect(current_path).to eq(createapps_path)
      end
    end

    describe "edit" do
      it "updates the createapp and redirects to its show page" do
        visit(createapp_path(createapp1))
        expect(current_path).to eq(createapp_path(createapp1))
        click_link('Edit')

        expect(find_field("Title").value).to eq("Createapp note title #1")
        expect(find_field("Body").value).to eq("createapp body #1")

        fill_in("Title", with: "New createapp note title")
        fill_in("Body", with: "New createapp note body")
        click_button("Update Createapp")

        expect(current_path).to eq(createapp_path(createapp1))
        expect(page).to have_content("New createapp note title")
      end
      it "does not update invalid createapps" do
        visit(createapp_path(createapp1))
        expect(current_path).to eq(createapp_path(createapp1))
        click_link('Edit')

        expect(find_field("Title").value).to eq("Createapp note title #1")
        expect(find_field("Body").value).to eq("createapp body #1")

        fill_in("Title", with: "")
        fill_in("Body", with: "New createapp note body")
        click_button("Update Createapp")

        expect(current_path).to eq(createapp_path(createapp1))
        expect(page).to_not have_content("New createapp note title")
        expect(page).to have_content("There was an error updating your 'createapp' note. Please try again.")
      end
      it "allows you to cancel updating 'Createapp Note'" do
        visit(createapp_path(createapp1))
        click_link("Edit")
        expect(current_path).to eq(edit_createapp_path(createapp1))
        click_on("Cancel")
        expect(current_path).to eq(createapp_path(createapp1))
      end

      # ==========================================
      # not sure how to test nested_attributes ???

      it "allows you to add comments" do
        visit(edit_createapp_path(createapp1))
        click_link('Add a comment')
        fill_in('Body', with: 'some comments') # it's not showing the comment's body; this is createapp's body ???
        click_button("Update Createapp")
      #  expect(current_path).to eq(createapp_path(createapp1))
      #  expect(page).to have_content('some comments')
      #  save_and_open_page
      end
      it "allows you to edit a comment" do
        visit(edit_createapp_path(createapp1))

      end

      it "allows you to remove a comment" do

      end

      it "allows you to add an image" do

      end

      it "allows you to remove an image" do

      end

    end

    describe "delete" do
      it "removes the createapp and show the its index page without the deleted createdapp" do
        visit(createapp_path(createapp1))
        expect(current_path).to eq(createapp_path(createapp1))
        click_link('Delete')

        expect(current_path).to eq(createapps_path)
        expect(page).to_not have_link(createapp1.title)
        #save_and_open_page
      end
    end

  end   # with a signed editor user


  describe "with a signed regular user" do
    before { login_as(regularuser) }

    describe "viewing the index page of createapps" do
      it "does not show the 'Add new Create App note'" do
        visit(createapps_path)
        expect(page).to_not have_link("Add new 'create app note'")
      end
    end

    describe "viewing the show page of createapp" do
      it "does not show the 'Edit' and 'Delete' links" do
        visit(createapp_path(createapp1))
       expect(page).to_not have_link("Edit")
       expect(page).to_not have_link("Delete")
      end
    end

  end   # with a signed regular user


end   # Createapp
