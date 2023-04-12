build_emulators_image:
	docker build -t trip-emulators:base \
	--build-arg FIREBASE_TOKEN=${TOKEN FROM firebase login:ci}
	.

run_emulators_image:
	docker run --rm -p 4000:4000 -p 8080:8080 -p 5001:5001 trip-emulators:base

add_default_data_for_container:
	docker exec trip-emulators:base sh && \
	npm run addFakeData

add_default_data:
	cd _backend && \
	npm i && \
	npm run addFakeData