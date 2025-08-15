# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  content         :text
#  notifiable_type :string           not null
#  notifiable_id   :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_notifications_on_notifiable  (notifiable_type,notifiable_id)
#

# frozen_string_literal: true
