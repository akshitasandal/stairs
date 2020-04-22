require "rails_helper"
RSpec.describe "blog_posts/edit" do
  it "infers the controller path" do
    expect(controller.request.path_parameters[:controller]).to eq("blog_posts")
    expect(controller.controller_path).to eq("blog_posts")
  end
end

RSpec.describe "blog_posts/abc/edit" do
  it "infers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("edit")
  end
end