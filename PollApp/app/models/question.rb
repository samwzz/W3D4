# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  poll_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  validates :text, :poll_id, presence: true

  has_many :answer_choices,
    class_name: "AnswerChoice",
    primary_key: :id,
    foreign_key: :question_id

  belongs_to :poll,
    class_name: "Poll",
    primary_key: :id,
    foreign_key: :poll_id

  has_many :responses,
    through: :answer_choices,
    source: :responses

  def results
    answer_choices = self.answer_choices

    results = {}

    answer_choices.each do |choice|
      results[choice] = choice.responses.count
    end

    results
  end

  def better_results
    answer_choices = self.answer_choices.includes(:responses)

    results = {}
    answer_choices.each do |choice|
      results[choice] = choice.responses.length
    end

    results
  end

  def best_results
    SELECT
      answer_choices.*, COUNT()
    FROM
      questions
    JOIN
      answer_choices ON questions.id = answer_choices.question_id
    JOIN
      responses ON answer_choices.id = responses.answer_id
    GROUP BY
      answer_choices
  end
end
