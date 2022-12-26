# frozen_string_literal: true

namespace :fly do
  task build: 'assets:precompile'
  task release: 'db:migrate'

  task server: :swapfile do
    sh 'bin/rails server'
  end

  task :swapfile do
    sh 'fallocate -l 512M /swapfile'
    sh 'chmod 0600 /swapfile'
    sh 'mkswap /swapfile'
    sh 'echo 10 > /proc/sys/vm/swappiness'
    sh 'swapon /swapfile'
  end
end
