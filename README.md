<div align="center">
  <br>
  <a href="http://learnertodriver.co.za/">
    <img
      alt="Learner to Driver"
      src="app/assets/images/favicon.png"
      width="100px"
    />
  </a>
  <br/>
  <h1>📚 📝 🚗</h1>
  <strong>Rails PWA with quizzes to get you ready for the SA learners test</strong>
</div>
<br/>
<p align="center">
  <a href="https://www.ruby-lang.org/en/">
    <img src="https://img.shields.io/badge/Ruby-v3.0.1-green.svg" alt="ruby version"/>
  </a>
  <a href="http://rubyonrails.org/">
    <img src="https://img.shields.io/badge/Rails-v6.1.3-brightgreen.svg" alt="rails version"/>
  </a>

## Getting Started

### Prerequisites

* [Ruby](https://www.ruby-lang.org/en/): we recommend using [rvm](https://rvm.io/) to install the Ruby version listed on the badge.
* [PostgreSQL](https://www.postgresql.org/) 9.4 or higher.

### Installation

0. Make sure all the prerequisites are installed.
1. Fork learnertodriver repository, ie. https://github.com/siyanda/learnertodriver/fork
2. Clone your forked repository, ie. `git clone https://github.com/<your-username>/learnertodriver.git`
3. `gem install bundler`
4. `bundle install`

5. `rails db:create`
6. `rails db:migrate`
7. `rails db:seed`

#### Starting the application

1.  `rails s`

<br/>

##User Roles

Administrator 'administrator' : has access to all the administration features within a single site.
Editor 'editor' : can publish and manage posts including the posts of other users.
Author 'author' : can publish and manage their own posts.
Contributor 'contributor' : can write and manage their own posts but cannot publish them.
Subscriber 'subscriber' : can only manage their profile.

##Question Types


##Quizz Options



<p align="center">
  <br/>
  <strong>Enjoy</strong> ❤️
</p>
