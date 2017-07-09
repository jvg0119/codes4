require 'rails_helper'

RSpec.describe CreateappsController, type: :controller do
  let(:regularuser) { create(:user, role: "regular")}
  let(:editoruser) { create(:user, role: "editor")}
  let(:createapp) { create(:arail_createapp) }
  let(:createapp2) { create(:arail_createapp, title: "Arail createapp title 2") }


# ==============================================================
# unsigned or guest user access
  describe "unsigned user access" do
    describe "GET #index" do
      # it "returns http success" do
      it "redirects to login url" do
        get :index
        #expect(response).to have_http_status(:success)
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #show" do
      it "redirects to login url" do
        get :show, params: { id: createapp.id }
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #edit" do
      it "redirects to login url" do
        patch :update, params: { id: createapp.id }
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "GET #new" do
      it "redirects to login url" do
        get :new
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "POST #create" do
      it "redirects to login url" do
        post :create, params: { createapp: attributes_for(:arail_createapp) }
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "PATCH #update" do
      it "redirects to login url" do
        patch :update, params: { id: createapp.id }
        expect(response).to redirect_to new_user_session_url
      end
    end

    describe "DELETE #destroy" do
      it "redirects to login url" do
        delete :destroy, params: { id: createapp.id }
        expect(response).to redirect_to new_user_session_url
      end
    end
  end   # unsigned user access


# ==============================================================
# signed or regular user access
# has access to index and show page only
# no access to edit & update, new & create, and destroy
  describe "signed regular user access" do
    before { sign_in(regularuser) }
    describe "GET #index" do
      before { get :index }
      it "returns http success" do
        #get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns all createapps to @createapps" do
        expect(assigns(:createapps)).to eq([createapp, createapp2])
      end
      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end   # GET #index

    describe "GET #show" do
      before { get :show, params: { id: createapp.id } }
      it "returns http success" do
        #get :show, params: { id: createapp.id }
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested createapp to @createapp" do
        expect(assigns(:createapp)).to eq(createapp)
      end
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
    end   # GET #show

    describe "GET #edit" do  # no access to edit    ### continue here later
      before { get :edit, params: { id: createapp.id } }
      it "redirects to root_url" do
        # expect(response).to have_http_status(:success)
        expect(response).to redirect_to root_path
      end
    end   # GET #edit

    describe "GET #new" do
      before { get :new }
      it "redirects to root_url" do
        expect(response).to redirect_to root_path
      end
    end   # GET #new

    describe "POST #create" do
      it "redirects to root_url" do
        #post :create, params: { createapp: attributes_for(:arail_createapp) }
        post :create, params: { arail_createapp: attributes_for(:arail_createapp) }
        expect(response).to redirect_to root_path
        #p attributes_for(:arail_createapp)
        #p params:  attributes_for(:arail_createapp)
      end
    end   # POST #create

    describe "PUT #update" do # all or partial update
      it "redirects to root_url" do
        put :update, params: { id: createapp.id, createapp: attributes_for(:arail_createapp, title: 'New title') }
        expect(response).to redirect_to root_path
      end
    end   # PUT #update

    describe "DELETE #destroy" do
      it "redirects to root_url" do
        delete :destroy, params: { id: createapp.id }
        expect(response).to redirect_to root_path
      end
    end   # DELETE #destroy
  end   # signed regular user access


  # ==============================================================
  # editor user access
  # has access to all the controller actions
  describe "signed edittor user access" do
    before { sign_in(editoruser) }
    describe "GET #index" do
      before { get :index }
      it "returns http success" do
        #get :index
        expect(response).to have_http_status(:success)
      end
      it "assigns all createapps to @createapps" do
        expect(assigns(:createapps)).to eq([createapp, createapp2])
      end
      it "renders the index template" do
        expect(response).to render_template(:index)
      end
    end

    describe "GET #show" do
      before { get :show, params: { id: createapp.id } }
      it "returns http success" do
        #get :show, params: { id: createapp.id }
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested createapp to @createapp" do
        expect(assigns(:createapp)).to eq(createapp)
      end
      it "renders the show template" do
        expect(response).to render_template(:show)
      end
    end

    describe "GET #edit" do
      before { get :edit, params: { id: createapp.id } }
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested createapp to @createapp" do
        expect(assigns(:createapp)).to eq(createapp)
      end
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
    end

    describe "GET #new" do
      before { get :new }
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "assigns the requested createapp to @createapp" do
        #expect(assigns(:createapp)).to be == (Arail::Createapp.new) # different object
        expect(assigns(:createapp)).to_not be_nil
      end
      it "renders the edit template" do
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "increases the number of 'createapp' by 1" do
          expect{ post :create, params: { arail_createapp: attributes_for(:arail_createapp) }
        }.to change{ Arail::Createapp.count }.by(1)
        end
        it "redirects to the newly created @createapp" do
          post :create, params: { arail_createapp: attributes_for(:arail_createapp, title: "title") }
          # post :create, params: { createapp: { title: 'mytitle', body: "createapp body" } } # this is OK in place of the above

          expect(response).to redirect_to(createapp_path(assigns(:createapp)))
          expect(response).to redirect_to(createapp_path(Arail::Createapp.last)) # OK
        end
      end
      context "with invalid attributes" do
        it "does not increase the number of 'createapp' by 1" do
          expect{ post :create, params: { arail_createapp: attributes_for(:arail_createapp, title: '') }
        }.to_not change{ Arail::Createapp.count }#.by(1)
        end
        it "re-renders back to the new template" do
          post :create, params: { arail_createapp: attributes_for(:arail_createapp, title: '') }
          expect(response).to render_template(:new)
        end
      end
    end

    describe "PUT #update" do
      describe "with valid attributes" do
        it "assigns createapp to be updated to @createapp" do
          put :update, params: { id: createapp.id, arail_createapp: attributes_for(:arail_createapp, title: 'New title') }
          expect(assigns(:createapp).title).to eq("New title")
        end
        it "redirects to the updated @createapp" do
          put :update, params: { id: createapp.id, arail_createapp: attributes_for(:arail_createapp, title: 'New title') }
          expect(response).to redirect_to(createapp_path(assigns(:createapp)))
          # different versions below:
          # expect(response).to redirect_to(:action => :show, :id => assigns(:createapp).id)
          # expect(response).to redirect_to(createapp_path(assigns(:createapp).id))
          # expect(response).to redirect_to("/createapps/#{assigns(:createapp).id}")
        end
      end
      describe "with invalid attributes" do
        it "does not assign createapp to @createapp" do
          put :update, params: { id: createapp.id, arail_createapp: attributes_for(:arail_createapp, title: nil, body: "createapp body")  }
          #put :update, params: { id: createapp.id, createapp: { title: '', body: "createapp body" } } # OK also
          expect(createapp.body).to eq("Arail createapp body")
        end
        it "re-renders back to edit template" do
          put :update, params: { id: createapp.id, arail_createapp: attributes_for(:arail_createapp, title: nil, body: "createapp body")  }
          expect(response).to render_template(:edit)
        end
      end
    end   # PUT #update

    describe "DELETE #destroy" do
      it "removes the selected @createapp #1" do
        delete :destroy, params: { id: createapp.id }
        expect(Arail::Createapp.where(id: createapp.id).size).to eq(0)
      end
      it "removes the selected @createapp #2" do
        createapp # needs the first object
        expect{ delete :destroy, params: { id: createapp.id }
      }.to change{Arail::Createapp.count}.from(1).to(0)
      end
      it "removes the selected @createapp #3" do
        createapp
        expect{ delete :destroy, params: { id: createapp.id }
      }.to change{Arail::Createapp.count}.by(-1)
      end
      it "redirects to the createapp index page" do
        delete :destroy, params: { id: createapp.id }
        expect(response).to redirect_to(createapps_path)
      end
    end   # DELETE #destroy
  end   # signed edittor user access

end
