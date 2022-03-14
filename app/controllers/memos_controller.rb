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
      @memo.save_tag(tag_list)
      redirect_to memos_path(@memo), notice: 'メモを作成しました'
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
    @memo = Memo.find(params[:id])
    tag_list=params[:memo][:name].split(',')
    if @memo.update(memo_params)
       @memo.save_tag(tag_list)
       redirect_to memo_path(@memo.id),notice:'投稿完了しました:)'
    else
      render:edit
    end
  end

  def destroy
  end
  private
  def memo_params
    params.require(:memo).permit(:title, :body)
  end

  def tag_params
      params.require(:memo).permit(:name)
  end
end
