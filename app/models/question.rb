class Question < ActiveRecord::Base
  belongs_to :user
  has_many :responses, dependent: :destroy, inverse_of: :question
  has_many :answers
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
  validate  :require_two_responses

  accepts_nested_attributes_for :responses

  private
    def require_two_responses
      errors.add(:base, "You must provide at least two answer choices") if responses.size < 2
    end
end
