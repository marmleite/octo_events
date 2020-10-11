require "rails_helper"

RSpec.describe EventsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/events").not_to be_routable
    end

    it "routes to #show" do
      expect(get: "/events/1").not_to be_routable
    end

    it "routes to #create" do
      expect(post: "/events").to route_to("events#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/events/1").not_to be_routable
    end

    it "routes to #update via PATCH" do
      expect(patch: "/events/1").not_to be_routable
    end

    it "routes to #destroy" do
      expect(delete: "/events/1").not_to be_routable
    end
  end
end
