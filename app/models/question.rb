# frozen_string_literal: true

class Question < ApplicationRecord
  has_many :quiz_question_linkages, dependent: :destroy
  has_many :quizzes, through: :quiz_question_linkages
  has_many :answers,         dependent: :destroy
  has_many :correct_answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :blank_new_answer?

  enum :kind, {
    single_choice:   10,
    multiple_choice: 20,
    long_answer:     30
  }, validate: true

  scope :random, -> { order(Arel::Nodes::NamedFunction.new('RANDOM', [])) }

  validates :kind,    presence: true
  validates :content, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id content information kind]
  end

  def self.ransackable_associations(_auth_object = nil) = []

  private

  def blank_new_answer?(attributes)
    attributes['id'].blank? && attributes.values_at('content', 'information').all?(&:blank?)
  end
end
