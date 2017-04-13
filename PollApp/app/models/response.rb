# == Schema Information
#
# Table name: responses
#
#  id         :integer          not null, primary key
#  answer_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Response < ApplicationRecord
  validates :answer_id, :user_id, presence: true
  validate :no_duplicate_responses
  validate :no_author_responses

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    primary_key: :id,
    foreign_key: :answer_id

  belongs_to :respondent,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end

  def author_response?
    self.question.poll.author_id == user_id
  end

  private

  def no_duplicate_responses
    if respondent_already_answered?
      errors[:base] << "Respondent already answered."
    end
  end

  def no_author_responses
    if author_response?
      errors[:base] << "Can't answer your own question."
    end
  end
end
