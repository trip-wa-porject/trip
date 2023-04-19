FROM --platform=linux/amd64 node:16.17.0-alpine

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

COPY / ./

RUN cd functions && \
    npm install && \ 
    npx tsc 

RUN apk --no-cache add openjdk11-jre bash && \
    npm install -g firebase-tools && \
    cd ..

CMD ["firebase", "emulators:start", "--project=wa-project-mountain"]   