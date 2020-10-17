require 'rails_helper'

RSpec.describe '/events', type: :request do
  # This are the minimal attributes permitted for a request from a GitHub webhook sender
  # The attributes are the essencial parts of the Event attribute 'payload'
  let(:valid_attributes) {
    {action: 'issue', sender: {}, repository: {}}
  }

  let(:signature) {
    ENV['SECRET_TOKEN'] = 'secret_token'
    'sha1=' + OpenSSL::HMAC.hexdigest(
      OpenSSL::Digest.new('sha1'),
      ENV['SECRET_TOKEN'],
      valid_attributes.to_json
    )
  }

  # This should return the minimal, that are:
  # X-GitHub-Event -> used as the attribute 'name' for the event created
  # X-GitHub-Delivery -> used as the attribute 'guid' for the event created
  # X-Hub-Signature -> used to authenticate the
  let(:valid_headers) {
    {
      'X-GitHub-Event' => 'issues',
      'X-GitHub-Delivery' => 'guid',
      'X-Hub-Signature' => signature,
      'Content-type' => 'application/json'
    }
  }

  describe 'POST /create' do
    context 'when authorized' do
      context 'with valid parameters and valid headers' do
        it 'renders created' do

          post events_url,
            params: valid_attributes, headers: valid_headers, as: :json

          expect(response).to have_http_status(:created)
        end
      end

      context 'without valid parameters' do
        it 'renders unprocessable_entity' do
          allow(self).to receive(:valid_attributes).and_return({})

          post events_url,
            params: valid_attributes, headers: valid_headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without action parameter' do
        it 'renders unprocessable_entity' do
          params_without_action = valid_attributes.except(:action)
          allow(self).to receive(:valid_attributes).and_return(params_without_action)

          post events_url,
            params: params_without_action, headers: valid_headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without sender parameter' do
        it 'renders unprocessable_entity' do
          params_without_sender = valid_attributes.except(:sender)
          allow(self).to receive(:valid_attributes).and_return(params_without_sender)

          post events_url,
            params: params_without_sender, headers: valid_headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without repository parameter' do
        it 'renders unprocessable_entity' do
          params_without_repository = valid_attributes.except(:repository)
          allow(self).to receive(:valid_attributes).and_return(params_without_repository)

          post events_url,
            params: params_without_repository, headers: valid_headers, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without valid headers' do
        it 'renders unauthorized' do
          post events_url,
            params: valid_attributes, headers: {}, as: :json

          expect(response).to have_http_status(:unauthorized)
        end
      end

      context 'without X-GitHub-Event header' do
        it 'renders unprocessable_entity' do
          headers_without_x_github_event = valid_headers.except('X-GitHub-Event')
          post events_url,
            params: valid_attributes, headers: headers_without_x_github_event, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'without X-GitHub-Delivery header' do
        it 'renders unprocessable_entity' do
          headers_without_x_github_delivery = valid_headers.except('X-GitHub-Delivery')
          post events_url,
            params: valid_attributes, headers: headers_without_x_github_delivery, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'without X-Hub-Signature header' do
      it 'renders unauthorized' do
        headers_without_x_hub_signature = valid_headers.except('X-Hub-Signature')
        post events_url,
          params: valid_attributes, headers: headers_without_x_hub_signature, as: :json

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /issues/:number/events' do
    context 'with valid query parameters' do
      before do
        Event.create!(
            name: 'issues',
            guid: 'guid',
            payload: {
              action: 'issue',
              issue: { number: 1 },
              repository: 'repo',
              sender: ''
            }
        )
      end

      it 'filter action by number' do
        events = Event.issues
        get '/issues/1/events'

        expect(response.body).to be == events.to_json(only: :payload)
      end
    end
  end
end
