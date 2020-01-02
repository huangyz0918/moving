---
layout: post
title: "Different between ENTRYPOINT and CMD in Dockerfile"
categories: misc
---

# ENTRYPOINT
> Defines the executable invoked when the container is started
>

# CMD
> specifies the argument that get passed to the `ENTRYPOINT`
>

Although you can use the `CMD` instruction to specify the command you want to execute when the image is run,
the correct way is to do it though the `ENTRYPOINT` instruction and to only specify the CMD if you want to define the default arguments.
