class MemosController < ApplicationController
  def index
    @tag_list = Tag.all
    @memos = Memo.page(params[:page]).per(5)
    @memo = current_user.memos.new
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.user_id=current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:memo][:name].split(',')
    if @memo.save
      @memo.save_memos(tag_list)
      redirect_to memos_path(@memo)
    else
      flash.now[:alert] = 'メモの作成に失敗しました'
      render:new
    end
  end

  def show
    @memo = Memo.find(params[:id])
    @memo_tags = @memo.tags
  end

  def edit
    @memo = Memo.find(params[:id])
    @tag_list=@memo.tags.pluck(:name).join(',')
  end

  def update
    @memo = current_user.memos.find(params[:id])
    tag_list = params[:memo][:name].split(',')
    if @memo.update(memo_params)
      @memo.save_memos(tag_list)
      redirect_to memos_path, success: '投稿を更新しました'
    else
      flash.now[:danger] = '投稿の更新に失敗しました'
      render :edit
    end
  end

  def destroy
    @memo = Memo.find(params[:id])
    @memo.destroy
    redirect_to memos_path
  end

  private
  def memo_params
    params.require(:memo).permit(:title, :body)
  end

  def tag_params
      params.require(:memo).permit(:name)
  end
end
