---
title: Test Matrix Space
emoji: 👁
colorFrom: gray
colorTo: green
sdk: docker
pinned: false
app_port : 4000
---

Check out the configuration reference at https://huggingface.co/docs/hub/spaces-config-reference

https://matix374657-test-matrix-space.hf.space

docker build --build-arg PUBLIC_TOKEN_SSH=$PUBLIC_TOKEN_SSH --build-arg SERVER_SSH_SECRETS=$SERVER_SSH_SECRETS -t glitch-example .  
docker run -p 3000:4000 glitch-example