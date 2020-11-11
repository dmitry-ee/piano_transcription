#!/bin/bash
ls -1 -- resources/*.mp3 | xargs -I{} python mp3tomidi.py {}