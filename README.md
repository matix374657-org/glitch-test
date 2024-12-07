---
title: Test Matrix Space
emoji: 👁
colorFrom: gray
colorTo: green
sdk: docker
pinned: false
app_port : 3000
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference
docker build -t glitch-example .  
docker run -p 7000:3000 glitch-example