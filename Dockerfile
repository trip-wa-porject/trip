FROM --platform=linux/amd64 node:16.17.0-alpine
# https://github.com/AndreySenov/firebase-tools-docker/blob/main/Dockerfile.node10

WORKDIR /app

EXPOSE 4000
EXPOSE 5000
EXPOSE 5001
EXPOSE 8080
EXPOSE 8085
EXPOSE 9000
EXPOSE 9005
EXPOSE 9099
EXPOSE 9199

ARG FIREBASE_TOKEN

ENV FIREBASE_TOKEN=${FIREBASE_TOKEN}

COPY .firebaserc .firebaserc
COPY firebase.json firebase.json
COPY firestore.indexes.json firestore.indexes.json
COPY firestore.rules firestore.rules 
COPY _backend/ ./

RUN npm install

RUN apk --no-cache add openjdk11-jre bash && \
    npm install -g firebase-tools && \
    firebase use wa-project-mountain --token=$FIREBASE_TOKEN

CMD ["firebase", "emulators:start", "--project=wa-project-mountain-dev"]    