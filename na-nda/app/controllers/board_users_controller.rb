class BoardUsersController < ApplicationController
	before_action :set_board_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_account!
	 layout 'board_users'

	def index
		users = BoardUser.where 'account_id == ?', current_account.id
		if users[0] == nil then
			user = BoardUser.new
			user.account_id = current_account.id
			user.nickname = '<<no name>>'
			user.save
			users = BoardUser.where 'account_id == ?', current_account.id
		end
		@board_user = users[0]
	end

	def show
		@board_user = BoardUser.find params[:id]
	end

	def new
		redirect_to '/board_messages'
	end

	def edit
		redirect_to '/board_messages'
	end

	def create
		redirect_to '/board_messages'
	end

	def update
		respond_to do |format|
			if @board_user.update(board_user_params)
				format.html { redirect_to '/board_messages' }
				format.json { render :show, status: :ok, location: @board_user }
			else
				format.html { render :index }
				format.json { render json: @board_user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		redirect_to '/board_messages'
	end

	private
	def set_board_user
		@board_user = BoardUser.find(params[:id])
	end

	def board_user_params
		params.require(:board_user).permit(:nickname, :account_id, :memo)
	end
end
