class EntriesController < ApplicationController
	before_action :login_required, except: [:index, :show]

  def index
  	if params[:user_id]
  		@user = Member.find(params[:user_id])
  		@entries = @user.entries
  	else
  		@entries = Entry.all
  	end
  	@entries = @entries.readable_for(current_user)
  	.order(posted_at: :desc).paginate(page: params[:page], per_page: 5)
  end

  def show
    @entry = Entry.readable_for(current_user).find(params[:id])
  end

  def new
    @entry = Entry.new(posted_at: Time.current)
  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end
end
