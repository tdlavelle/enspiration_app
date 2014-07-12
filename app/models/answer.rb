class Answer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :response_id, presence: true
  belongs_to :user
  belongs_to :question
  belongs_to :response
end
