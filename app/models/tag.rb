class Tag < ApplicationRecord
  before_save :downcase_name
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :memos, through: :tag_maps

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }

  private
    # タグ名を小文字に変換
    def downcase_name
      self.name.downcase!
    end
end
