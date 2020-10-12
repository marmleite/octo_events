require 'rails_helper'

RSpec.describe EventsController, type: :routing do
  describe 'routing' do
    context 'not available' do
      it '#index not to be routable' do
        expect(get: '/events').not_to be_routable
      end

      it '#show not to be routable' do
        expect(get: '/events/1').not_to be_routable
      end

      it '#update via PUT not to be routable' do
        expect(put: '/events/1').not_to be_routable
      end

      it '#update via PATCH not to be routable' do
        expect(patch: '/events/1').not_to be_routable
      end

      it '#destroy not to be routable' do
        expect(delete: '/events/1').not_to be_routable
      end
    end

    context 'available' do
      it '#create not to be routable' do
        expect(post: '/events').to route_to('events#create')
      end
    end
  end
end
