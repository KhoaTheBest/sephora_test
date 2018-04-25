RSpec.shared_examples "respond to missing" do |url|
  before do
    get url
  end

  it "responds with 404" do
    expect(last_response.status).to eq 404
  end

  it "responds with error" do
    message = json["msg"]
    expect(message).to eq("Not Found")
  end
end
