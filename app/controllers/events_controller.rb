class EventsController < ApplicationController

  # POST /events
  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private
    # Set the attributes to the event param
    # the request body is passed as the payload attribute
    def event_params
      params[:event][:payload] = JSON.parse(request.body.to_json).first
      params[:event][:name] = request.headers['X-GitHub-Event']
      params[:event][:guid] = request.headers['X-GitHub-Delivery']
      params.require(:event).permit(:name, :guid, :payload)
    end
end
