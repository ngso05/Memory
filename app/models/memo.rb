class Memo < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  belongs_to :user

  def save_tags(tag_list)
    tag_list.each do |tag|
      # 受け取った値を小文字に変換して、DBを検索して存在しない場合は
      # find_tag に nil が代入され　nil となるのでタグの作成が始まる
      unless find_tag = Tag.find_by(name: tag.downcase)
        begin
          # create メソッドでタグの作成
          # create! としているのは、保存が成功しても失敗してもオブジェクト
          # を返してしまうため、例外を発生させたい
          self.tags.create!(name: tag)
        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else
            # DB にタグが存在した場合、中間テーブルにブログ記事とタグを紐付けている
        ArticleTagRelation.create!(memo_id: self.id, tag_id: find_tag.id)
      end
    end
  end
end
