# frozen_string_literal: true

class Admin::SidebarNav::Component < ApplicationViewComponent
  Item = Data.define(:label, :path, :icon)

  ITEMS = [
    ['Dashboard',   :admin_path,                      'icons/dashboard.svg'],
    ['Users',       :admin_users_path,                'icons/user.svg'],
    ['Quizzes',     :admin_quizzes_path,              'icons/performance.svg'],
    ['Questions',   :admin_questions_path,            'icons/chat-o.svg'],
    ['Evaluations', :admin_evaluations_path,          'icons/chart.svg'],
    ['Posts',       :admin_posts_path,                'icons/newspaper-o.svg'],
    ['Pages',       :admin_pages_path,                'icons/pages.svg'],
    ['Comments',    :admin_comments_path,             'icons/comments.svg'],
    ['Tags',        :admin_tags_path,                 'icons/hashtag.svg'],
    ['Jobs',        :admin_mission_control_jobs_path, 'icons/tools.svg'],
  ].freeze

  option :current_path, required: true

  def items
    ITEMS.map { |label, route, icon| Item.new(label:, path: helpers.public_send(route), icon:) }
  end

  def active?(item)
    return current_path == item.path if item.path == helpers.admin_path

    current_path.start_with?(item.path)
  end
end
