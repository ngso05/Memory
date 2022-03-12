class MemosController < ApplicationController
  def index
    @tag_list = Tag.all              #ビューでタグ一覧を表示するために全取得。
    @memos = Memo.all                #ビューで投稿一覧を表示するために全取得。
    # @memo = current_user.memos.new
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    @memo.user_id = current_user.id
    tag_list = tag_params[:names].split(/[[:blank:]]+/).select(&:present?)
    memo.save
    if @memo.save
      @memo.save_tag(tag_list)
      redirect_to memos_path
    else
      render 'new'
    end
  end

  def show
    @memo = Memo.find(params[:id])  #クリックした投稿を取得。
    @memo_tags = @memo.tags
  end

  def edit
  end

  def update
  end

  def destroy
  end
  private
  def memo_params
    params.require(:memo).permit(:title, :body)
  end
  
  def tag_params
      params.require(:memo).permit(:names)
  end
end
