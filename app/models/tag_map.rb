class TagMap < ApplicationRecord
  belongs_to :memo
  belongs_to :tag

  validates :memo_id, presence: true
  validates :tag_id, presence: true
end
