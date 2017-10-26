require 'rails_helper'

RSpec.describe Api::PhotosController, type: :controller do
  let!(:user1) { User.create!(email: "test@test.com", password: "password") }
  let!(:user2) { User.create!(email: "test2@test.com", password: "password") }

  let!(:photo1) { user1.photos.create!(title: "Test", photo_content: File.open("spec/fixtures/test.png")) }
  let!(:photo2) { user1.photos.create!(title: "Another", photo_content: File.open("spec/fixtures/test.png")) }
  let!(:photo3) { user2.photos.create!(title: "My Photo!", photo_content: File.open("spec/fixtures/test.png")) }

  before do
    request.env["HTTP_ACCEPT"] = "application/json"
  end

  describe "GET show" do
    it "renders a single photo" do
      get :show, params: { id: photo1.id }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq(
        "title" => "Test",
        "id" => photo1.id,
        "created_at" => photo1.created_at.iso8601(3),
        "updated_at" => photo1.updated_at.iso8601(3),
        "photo_content" => { "url" => photo1.photo_content.url },
        "user_id" => user1.id
      )
    end

    it "is a 404 when missing the photo" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "GET index" do
    it "renders all photos in order of creation DESC" do
      get :index
      expect(response.status).to eq(200)
      body = JSON.parse(response.body)
      expect(body.length).to eq(3)
      expect(body.map { |h| h["id"] }).to eq([photo3.id, photo2.id, photo1.id])
    end

    it "is a 404 when missing the photo" do
      get :show, params: { id: 0 }
      expect(response.status).to eq(404)
    end
  end

  describe "POST #create" do
    it "requires an authorized user" do
      post :create
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)).to eq("error" => "Not authorized")
    end

    context "when authorized" do
      before do
        request.headers["Authorization"] = "Bearer: #{user1.get_auth_token}"
      end

      it "requires all properties to be present" do
        post :create
        expect(response.status).to eq(422)
        expect(JSON.parse(response.body)).to eq("errors" => { "title" => ["can't be blank"], "photo_content" => ["can't be blank"] })
      end

      it "creates a photo successfully" do
        file = fixture_file_upload('spec/fixtures/test.png', 'image/png')

        expect {
          post :create, params: { title: "Test", photo_content: file }
          expect(response.status).to eq(201)
        }.to change { Photo.count }.by(1)

        photo = Photo.last
        expect(JSON.parse(response.body)).to eq(
          "title" => "Test",
          "id" => photo.id,
          "created_at" => photo.created_at.iso8601(3),
          "updated_at" => photo.updated_at.iso8601(3),
          "photo_content" => { "url" => photo.photo_content.url },
          "user_id" => user1.id
        )
      end
    end
  end
end
