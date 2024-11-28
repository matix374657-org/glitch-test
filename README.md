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

docker build -t glitch-example .  
docker run -e PUBLIC_TOKEN_SSH=$(echo $PUBLIC_TOKEN_SSH) -e SERVER_SSH_SECRETS=$(echo $SERVER_SSH_SECRETS) -p 3000:4000 glitch-example