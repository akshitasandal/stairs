require "rails_helper"
RSpec.describe "post_categories/edit" do
  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq("post_categories")
    expect(controller.controller_path).to eq("post_categories")
  end
end

RSpec.describe "post_categories/abc/edit" do
  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("edit")
  end
end