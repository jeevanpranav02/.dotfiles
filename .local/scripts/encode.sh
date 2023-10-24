#!/usr/bin/env bash
mkdir -p transcoded

for i in *.mp4; do
    ffmpeg -i "$i" -vcodec mjpeg -q:v 1 -acodec pcm_s16le -q:a 1 -f mov "transcoded/${i%.*}.mov";
done
