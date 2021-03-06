require "rails_helper"
RSpec.describe "users/edit" do
  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq("users")
    expect(controller.controller_path).to eq("users")
  end
end

RSpec.describe "users/abc/edit" do
  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("edit")
  end
end