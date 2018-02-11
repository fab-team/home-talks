class EntriesController < ApplicationController
	before_action :login_required, except: [:index, :show]

  # 記事一覧
  def index
    if params[:tag]
      # tagのハッシュがあった時
      # tagged_withでタグ「:tag」でタグごとにフィルター
      @entries = Entry.tagged_with(params[:tag])
    elsif params[:user_id]
      # user_idのハッシュがあった時
      @user = User.find(params[:user_id])
      @entries = @user.entries
    else
      @entries = Entry.all
    end
    @entries = @entries.readable_for(current_user)
    .order(posted_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  # 記事の詳細
  def show
    @entry = Entry.readable_for(current_user).find(params[:id])
  end

  # 新規登録フォーム
  def new
    @entry = Entry.new(posted_at: Time.current)
    # @all_tag_list = ActsAsTaggableOn::Tag.for_context(:sex_list).pluck(:name)
    # @all_tag_list = ActsAsTaggableOn::Tag.for_context(:sex_list).pluck(:name)
    @all_tag_list = ActsAsTaggableOn::Tag.all.pluck(:name)
    # @all_tag_list = ActsAsTaggableOn::Tag.for_context(:sex_list)
  end

  # 編集
  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.author = current_user
    if @entry.save
      redirect_to @entry, notice: "記事を作成しました。"
    else
      render "new"
    end
  end

  def update
    @entry = current_user.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice: "記事を更新しました。"
    else
      render "edit"
    end
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to :entries, notice: "記事を削除しました。"
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body, :posted_at, :status, :tag_list, :sex_list, :job_list)
  end

end
