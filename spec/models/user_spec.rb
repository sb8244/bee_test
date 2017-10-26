require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#get_auth_token" do
    it "returns a JWT token for this user id" do
      (1..3).each do |id|
        user = User.new(id: id)
        token = user.get_auth_token
        expect(JWT.decode(token, nil, false)[0]).to eq("id" => id)
      end
    end
  end

  describe ".load_from_token" do
    it "loads a user successfully" do
      user = User.create!(email: "test@test.com", password: "password")
      expect(User.load_from_token(user.get_auth_token)).to eq(user)
    end

    it "is an ActiveRecord::RecordNotFound with an invalid token" do
      expect {
        User.load_from_token("nope")
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
