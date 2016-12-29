# jekyll-sites
Personal organizer for multiple sites built from Jekyll.

### Installation
1. Install Google Cloud SDK
1. Make a Google Cloud bucket for your domain with default object permissions User: allUsers Read
1. Begin here with dependencies:

    make update

1. Generate sites.mk, which lists the local directories and their buckets:

    www.example.com: BUCKET ?= gs://www.example.com
    en.example.com: BUCKET ?= gs://en.example.com

1. Collect your Jekyll content. Use one of the following commands:

    git clone your_repo www.example.com # the most straightforward
    git clone -b gh-pages your_repo www.example.com # if coming from github
    git submodule add -b gh-pages your_repo www.example.com # if you're using this build system with others

### Usage

Follow the usual directions for Jekyll. Add posts as individual files in _posts.
Add your theme to the Gemfile like so:

    gem 'jekyll-theme-name'

And your _config.yml:

    theme: jekyll-theme-name

See your local configuration:

    make

Generate the static site and push it to its bucket, overwriting the contents:

    make www.example.com

Run a mock server locally, i.e. on http://127.0.0.1:4000

    bundle exec jekyll serve -s www.example.com
