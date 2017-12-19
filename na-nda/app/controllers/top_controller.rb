class TopController < ApplicationController
  def index
    if params[:member_id]
      @member = Member.find(params[:member_id])
      @entries = @member.entries
    else
      @entries = Entry.all
    end
    @entries = @entries.readable_for(current_member)
    .order(posted_at: :desc).paginate(page: params[:page], per_page: 5)
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
