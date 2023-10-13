<!-- Banner Image -->
<img src="https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdevnotebooks.png" width="100%">

<!-- Links -->
<p align="center">
  <a href="https://console.brev.dev" style="color: #06b6d4;">Console</a> •
  <a href="https://brev.dev" style="color: #06b6d4;">Docs</a> •
  <a href="/" style="color: #06b6d4;">Templates</a> •
  <a href="https://discord.gg/NVDyv7TUgJ" style="color: #06b6d4;">Discord</a>
</p>

# Brev.dev Notebooks

This repo contains helpful AI/ML notebook templates. Each notebook has been coupled with the minimum GPU specs required to use them + setup scripts making a Brev template. Click the deploy badge on any notebook to deploy it.

## Notebooks

<!-- make a table  -->

| Notebook         | Description                          | Min. GPU     | Deploy                                                                                                                                                                                                                                                                                                                                   |
| ---------------- | ------------------------------------ | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Fine-tune Llama 2](https://github.com/brevdev/notebooks/blob/main/llama2-finetune.ipynb) | Fine-tune Llama 2 on your own dataset | 1x A10G | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1RB0xrrb1GuaTRZ2qjCKuoySmRn5d-lky/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=g4dn.xlarge&name=fine-tune-llama2) |
| [Fine-tune Mistral](https://github.com/brevdev/notebooks/blob/main/mistral-finetune.ipynb) | A Guide to Cheaply Fine-tuning Mistral | 1x A10G | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1mlr4apb3zM9mxkQMBlbC1CdjorqK6pIx/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=g5.xlarge&name=mistral-finetune) |
| [Fine-tune Mistral - Own Data](https://github.com/brevdev/notebooks/blob/main/mistral-finetune-own-data.ipynb) | Fine-tune Mistral on your own dataset | 1x A10G | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1n_XpTFn10_64NkcHmEF8CUm3E43sPQUo/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=g5.xlarge&name=mistral-finetune) |
| [Julia Install](https://github.com/brevdev/notebooks/blob/main/julia-install.ipynb) | Easily Install Julia + Notebooks | any \|\| CPU | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1RDnIu87b6a7Uu6Kc8EkJoenq8toVknkj/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=t3a.medium&name=julia) |
---

### What is Brev.dev?

Brev is a dev tool that makes it really easy to code on a GPU in the cloud. Brev does 3 things: provision, configure, and connect.

#### Provision:

Brev provisions a GPU for you. You don't have to worry about setting up a cloud account. We have solid GPU supply, but if you do have AWS or GCP, you can link them.

#### Configure:

Brev configures your GPU with the right drivers and libraries. Use our open source tool Verb to point and click the right python and CUDA versions.

#### Connect:

Brev.dev CLI automatically edits your ssh config so you can `ssh gpu-name` or run `brev open gpu-name` to open VS Code to the remote machine
