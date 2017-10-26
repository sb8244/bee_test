require 'rails_helper'

RSpec.describe Api::UploadsController, type: :controller do
  let!(:user) { User.create!(email: "test@test.com", password: "password") }

  before do
    request.env["HTTP_ACCEPT"] = "application/json"
  end

  describe "POST #create" do
    it "requires an authorized user" do
      post :create
      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)).to eq("error" => "Not authorized")
    end

    context "when authorized" do
      before do
        request.headers["Authorization"] = "Bearer: #{user.get_auth_token}"
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
          "user_id" => user.id
        )
      end
    end
  end
end
