current_mk_abspathname := $(abspath $(lastword $(MAKEFILE_LIST)))
current_mk_absdir := $(dir $(current_mk_abspathname))

build_emulators_image:
	docker build -t trip-emulators:base .

run_emulators_image:
	docker run -v $(current_mk_absdir):/app --rm -p 4000:4000 -p 8080:8080 -p 5001:5001 trip-emulators:base

add_default_data:
	cd _backend && \
	npm i && \
	npm run addFakeData


# export PATH=[PATH_TO_FLUTTER_GIT_DIRECTORY]/flutter/bin:$PATH
# export firebase APIKEY
run-flutter:
	cd frontend && \
	flutter run -d chrome --dart-define FLUTTER_APIKEY=$(FLUTTER_APIKEY) --web-renderer html