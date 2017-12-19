class BoardMessagesController < ApplicationController
	before_action :set_board_message, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_account!
	layout 'board_messages'

	def index
		@board_messages = BoardMessage.page(params[:page]).order('created_at desc')
		users = BoardUser.where 'account_id == ?', current_account.id
		if users[0] == nil then
			user = BoardUser.new
			user.account_id = current_account.id
			user.nickname = '<<no name>>'
			user.save
			users = BoardUser.where 'account_id == ?', current_account.id
		end
		@board_user = users[0]
		@board_message = BoardMessage.new
		@board_message.board_user_id = @board_user.id
	end

	def show
		# @board_message = BoardMessage.new
    @board_message.board_user_id = params[:id]
	end

	def new
		redirect_to '/board_messages'
	end

	def edit
		redirect_to '/board_messages'
	end

	def create
		@board_messages = BoardMessage.page(params[:page]).order('created_at desc')
		@board_message = BoardMessage.new(board_message_params)
		@board_user = BoardUser.where('account_id == ?', current_account.id)[0]
		respond_to do |format|
			if @board_message.save
				format.html { redirect_to '/board_messages' }
				format.json { render :show, status: :created, location: @board_message }
			else
				format.html { render :index }
				format.json { render json: @board_message.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		redirect_to '/board_messages'
	end

	def destroy
		redirect_to '/board_messages'
	end

	private
	def set_board_message
		@board_message = BoardMessage.find(params[:id])
	end

	def board_message_params
		params.require(:board_message).permit(:content, :board_user_id)
	end
end
