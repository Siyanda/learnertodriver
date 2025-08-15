# == Schema Information
#
# Table name: taggings
#
#  id            :integer          not null, primary key
#  taggable_id   :integer
#  taggable_type :string
#  tag_id        :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_taggings_on_tag_id                         (tag_id)
#  index_taggings_on_taggable_type_and_taggable_id  (taggable_type,taggable_id)
#

# frozen_string_literal: true

class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end
