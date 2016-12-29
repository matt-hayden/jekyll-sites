
.PHONY: .bundle/config _site diag update
include sites.mk

diag:
	@gsutil version
	@echo gsutil using native modules:
	@gsutil version -l | sed -n 's/\s*[Cc]ompiled\s*/    /p'
	@echo
	@echo Gemfile
	@sed 's/^\s*/    /' Gemfile
	@echo
	bundle show
	@echo
	@echo sites.mk
	@sed 's/^/    /' sites.mk

.bundle/config: Gemfile
	bundler --version || gem install --user-install bundler
	bundler install --path vendor/bundle
update: Gemfile
	[ -f .bundle/config ] && bundle update
	[ -f .gitmodules ] && git submodules update --init || echo You may want to update your repos

%.com %.edu %.gy %.net %.org %.us: _site
	bundle exec jekyll build -s "$@"
	gsutil -m rsync -r -d _site $(BUCKET)
.PHONY: _site
