image_name := "dmi7ry/piano-transcription:0.1"
container_name := "piano"

build:
  docker build . -t {{image_name}} -f Dockerfile

run:
  docker run -it --rm --name {{container_name}} \
    -v $(pwd):/app \
    -v $(pwd)/data:/root/piano_transcription_inference_data/ \
    {{image_name}} bash

clean:
  docker images | grep none | awk '{ print $3 }' | xargs -I{} docker rmi -f {}
  docker rm -f $(docker ps -aq)