build:
	docker build -t _hhvm .

test:
	rspec \
		--format doc \
		--color \
		spec/*_spec.rb
