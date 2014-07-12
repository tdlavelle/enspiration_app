class Response < ActiveRecord::Base
  belongs_to :question
  has_many :answers
  default_scope -> { order('created_at ASC') }
  validates :question, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
