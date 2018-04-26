RSpec.shared_examples "respond to success" do
  it "responds with a 200 status" do
    expect(last_response.status).to eq 200
  end
end
