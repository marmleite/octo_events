class EventsController < ApplicationController
  before_action :verify_signature

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render nothing: true, status: :created
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private
    # Set the attributes to the event param
    # the request body is passed as the payload attribute
    def event_params
      params[:event][:payload] = @json_payload
      params[:event][:name] = request.headers['X-GitHub-Event']
      params[:event][:guid] = request.headers['X-GitHub-Delivery']
      params.require(:event).permit(:name, :guid, :payload)
    end

    def verify_signature

      @json_payload = request.body.read

      request_signature = request.headers.env['HTTP_X_HUB_SIGNATURE']
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(
        OpenSSL::Digest.new('sha1'),
        ENV['SECRET_TOKEN'],
        @json_payload
      )

      unless request_signature && Rack::Utils.secure_compare(signature, request_signature)
        render nothing: true, status: :unauthorized
      end
    end
end
