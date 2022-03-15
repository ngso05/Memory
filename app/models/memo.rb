class Memo < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true

  def save_memos(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      memo_tag = Tag.find_or_create_by(name: new_name)
      self.tags << memo_tag
    end
  end
end
