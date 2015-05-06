require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:context) do
    User.delete_all
  end

  def user_params
    { first_name: "fake", last_name: "user", email: "fake@example.com", password: "1234" }
  end

  describe "GET index" do
    it "assigns @users and renders the index template" do
      user = User.create user_params
      get :index

      # expect an array with the single user that we created
      expect(assigns(:users)).to eq([user])
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    it "assigns @user and renders the show template" do
      user = User.create user_params
      get :show, id: user.id

      # expect assigned user to be the created user
      expect(assigns(:user)).to eq(user)
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    it "sets @user and renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST create" do
    it "creates a user and redirects to index" do
      expect {
        post :create, user: user_params
      }.to change(User, :count).by 1

      expect(response).to redirect_to(login_path)
    end

    it "does not create an invalid user." do
      expect {
        post :create, user: { first_name: nil}
      }.not_to change(User, :count)
    end
  end

end
