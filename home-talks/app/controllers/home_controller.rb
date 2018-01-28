class HomeController < ApplicationController
  def index
    @entries = Entry.all
    @entries = @entries.readable_for(current_user)
    .order(posted_at: :desc).paginate(page: params[:page], per_page: 5)

    # @entries = Entry.open.readable_for(current_user)
    #   .order(released_at: :desc).limit(5)
  end

  def about
  end

  def not_found
    raise ActionController::RoutingError,
      "No route matches #{request.path.inspect}"
  end

  def bad_request
    raise ActionController::ParameterMissing, ""
  end

  def internal_server_error
    raise Exception
  end

end
