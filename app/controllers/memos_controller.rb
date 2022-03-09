class MemosController < ApplicationController
  def index
  end

  def new
    @memo = Memo.new
  end

  def create
    @memo = Memo.new(memo_params)
    memo.save
    if @memo.save
      redirect_to memos_path
    else
      render 'new'
    end
  end
  
  def show
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
end
