require 'spec_helper'

describe DiscourseApi::API::ApiAdmin do
  subject {
    DiscourseApi::Client.new(
      "http://localhost:3000",
      "test_d7fd0429940",
      "test_user"
    )
  }

  describe "#api" do
    before do
      url = "http://localhost:3000/admin/api.json?" +
            "api_key=test_d7fd0429940&api_username=test_user"
      stub_get(url).to_return(body: fixture("api.json"),
                              headers: { content_type: "application/json" })
    end

    it "requests the correct resource" do
      subject.api
      url = "http://localhost:3000/admin/api.json?" +
            "api_key=test_d7fd0429940&api_username=test_user"
      expect(a_get(url)).to have_been_made
    end

    it "returns the requested api keys" do
      api = subject.api
      expect(api).to be_an Array
      expect(api.first).to be_a Hash
      expect(api.first).to have_key('key')
    end
  end

  describe "#generate_api_key" do
    before do
      url = "http://localhost:3000/admin/users/2/generate_api_key.json?" +
            "api_key=test_d7fd0429940&api_username=test_user"
      stub_post(url).to_return(body: fixture("generate_api_key.json"),
                               headers: { content_type: "application/json" })
    end

    it "returns the generated api key" do
      api_key = subject.generate_api_key(2)
      expect(api_key).to be_a Hash
      expect(api_key['api_key']).to have_key('key')
    end

  end
end