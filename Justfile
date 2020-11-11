image_repo := "dmi7ry"
image_name := "piano-transcription"
image_version := "0.1"
image_full_name := image_repo + "/" + image_name + ":" + image_version
container_name := "piano"

_build IMAGE_NAME=(image_name) DOCKERFILE="Dockerfile":
  docker build . -t {{image_repo}}/{{IMAGE_NAME}}:{{image_version}} -f {{DOCKERFILE}}
build:
  just _build {{image_name}}
build-gpu:
  just _build {{image_name}}-gpu Dockerfile-gpu

run IMAGE_NAME=(image_name):
  docker run -it --rm --name {{container_name}} \
    -v $(pwd):/app \
    -v $(pwd)/data:/root/piano_transcription_inference_data/ \
    {{image_repo}}/{{IMAGE_NAME}}:{{image_version}} bash

run-gpu:
  just run {{image_name}}-gpu

clean:
  docker images | grep none | awk '{ print $3 }' | xargs -I{} docker rmi -f {}
  docker ps -aq | xargs -I{} docker rm -f {}