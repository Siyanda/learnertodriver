# frozen_string_literal: true

pages = [
  { 'title' => 'About', 'content' => rendered_md('page/about'), 'slug' => 'about', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Conduct', 'content' => rendered_md('page/conduct'), 'slug' => 'conduct', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'FAQ', 'content' => rendered_md('page/faq'), 'slug' => 'faq', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Terms & Conditions', 'content' => rendered_md('page/terms'), 'slug' => 'terms',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Use Restrictions Policy', 'content' => rendered_md('page/abuse'), 'slug' => 'abuse',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Account Ownership Information', 'content' => rendered_md('page/account-ownership-information'),
    'slug' => 'account-ownership-information', 'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Cancellation Policy', 'content' => rendered_md('page/cancellation'), 'slug' => 'cancellation',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Support Community', 'content' => rendered_md('page/community'), 'slug' => 'community',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Contact', 'content' => rendered_md('page/contact'), 'slug' => 'contact', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Incapacitated', 'content' => rendered_md('page/incapacitated'), 'slug' => 'incapacitated',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Careers', 'content' => rendered_md('page/jobs'), 'slug' => 'jobs', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Partners', 'content' => rendered_md('page/partnership'), 'slug' => 'partnership',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Policies', 'content' => rendered_md('page/policies'), 'slug' => 'policies', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Privacy Policy', 'content' => rendered_md('page/privacy'), 'slug' => 'privacy',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Purpose', 'content' => rendered_md('page/purpose'), 'slug' => 'purpose', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Refund Policy', 'content' => rendered_md('page/refund'), 'slug' => 'refund', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Service Level Agreement (SLA)', 'content' => rendered_md('page/sla'), 'slug' => 'sla',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Security Overview', 'content' => rendered_md('page/security'), 'slug' => 'security',
    'status' => 'published', 'user_id' => User.first.id, 'parent_id' => '' },
  { 'title' => 'Taxes', 'content' => rendered_md('page/taxes'), 'slug' => 'taxes', 'status' => 'published',
    'user_id' => User.first.id, 'parent_id' => '' }
]

pages.each do |data|
  Page.create!(data)
end
