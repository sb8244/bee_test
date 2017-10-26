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
end
