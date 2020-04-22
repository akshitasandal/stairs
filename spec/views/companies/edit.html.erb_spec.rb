require "rails_helper"
RSpec.describe "companies/edit" do
  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq("companies")
    expect(controller.controller_path).to eq("companies")
  end
end

RSpec.describe "companies/abc/edit" do
  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("edit")
  end
end