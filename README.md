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

| Notebook                                                                                                       | Description                            | Min. GPU     | Deploy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| -------------------------------------------------------------------------------------------------------------- | -------------------------------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Fine-tune Llama 2](https://github.com/brevdev/notebooks/blob/main/llama2-finetune.ipynb)                      | Fine-tune Llama 2 on your own dataset  | 1x A10G      | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1RB0xrrb1GuaTRZ2qjCKuoySmRn5d-lky/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=A10G:g5.xlarge&name=fine-tune-llama2)                                                                                                                                                         |
| [Fine-tune Mistral](https://github.com/brevdev/notebooks/blob/main/mistral-finetune.ipynb)                     | A Guide to Cheaply Fine-tuning Mistral | 1x A10G      | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1roX2FWW39Wnrsdtk8vM7p8A97NG41sd9/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=A10G:g5.xlarge&name=mistral-finetune)                                                                                                                                                         |
| [Fine-tune Mistral - Own Data](https://github.com/brevdev/notebooks/blob/main/mistral-finetune-own-data.ipynb) | Fine-tune Mistral on your own dataset  | 1x A10G      | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1uTVLrro5vbg5zCmMWo-wYIj1jf4N-GDY/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=A10G:g5.xlarge&name=mistral-finetune) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/youtubebadge.svg)](https://www.youtube.com/watch?v=kmkcNVvEz-k&t=1s) |
| [Julia Install](https://github.com/brevdev/notebooks/blob/main/julia-install.ipynb)                            | Easily Install Julia + Notebooks       | any \|\| CPU | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1RDnIu87b6a7Uu6Kc8EkJoenq8toVknkj/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=n1-standard-1&panel=CPU&name=julia)                                                                                                                                                           |
| [Deploy to Replicate](https://github.com/brevdev/notebooks/blob/main/deploy-to-replicate.ipynb)                | Deploy Model to Replicate              | any \|\| CPU | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1R6iVHB0xb2b3u0cGrPdWTLszjCZhdmib/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=n1-standard-1&panel=CPU&name=deploy) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/youtubebadge.svg)](https://www.youtube.com/watch?v=eczHFcqx1ic&t=3s)  |
| [PDF Chatbot (OCR)](https://github.com/brevdev/notebooks/blob/main/ocr-pdf-analysis.ipynb)                     | PDF Chatbot using OCR              | 1x A10G | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1McrxpU5HAdJ_l6kd1Byb1U_fj6TTODt-/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=A10G:g5.xlarge&name=pdf-analysis)
| [Zephyr Chatbot](https://github.com/brevdev/notebooks/blob/main/zephyr-chatbot.ipynb)                     | Chatbot with Open Source Models              | 1x A10G | [![Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://drive.google.com/file/d/1LdlDaduPMizWsHHhKKKcbCbYUstSN_w4/view?usp=sharing) [![](https://uohmivykqgnnbiouffke.supabase.co/storage/v1/object/public/landingpage/brevdeploynavy.svg)](https://console.brev.dev/environment/new?instance=A10G:g5.2xlarge&diskStorage=256)


---

### What is Brev.dev?

Brev is a dev tool that makes it really easy to code on a GPU in the cloud. Brev does 3 things: provision, configure, and connect.

#### Provision:

Brev provisions a GPU for you. You don't have to worry about setting up a cloud account. We have solid GPU supply, but if you do have AWS or GCP, you can link them.

#### Configure:

Brev configures your GPU with the right drivers and libraries. Use our open source tool Verb to point and click the right python and CUDA versions.

#### Connect:

Brev.dev CLI automatically edits your ssh config so you can `ssh gpu-name` or run `brev open gpu-name` to open VS Code to the remote machine
