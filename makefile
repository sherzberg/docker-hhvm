build:
	docker build -t _hhvm .

test:
	rspec \
		--format doc \
		--color \
		spec/dockerfile_spec.rb
