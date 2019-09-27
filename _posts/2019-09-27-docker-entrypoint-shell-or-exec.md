---
layout: post
title: "shell or exec form for ENTRYPOINT?"
categories: misc
---
When you define a Docker image with Dockefile, you have 2 options with `ENTRYPOINT` instruction
- shell form - `ENTRYPOINT node app.js`
- exec form - `ENTRYPOINT ["node", "app.js"`

Have you asked yourself what is different between shell form and exec form above?
The answer is very simple, the difference is whether the specified command is invoker inside a shell or not.

## Talk is cheap, show me the code!
app.js

```js
import http from 'http';

http.createServer((req, res) => {
  res.write('Hello there!');
  res.end();
}).listen(8080);
```
Dockerfile

```dockerfile
FROM node:12.7.0
ADD app.js ./app.js

ENTRYPOINT ["node", "app.js"]
```

Build image

```bash
$ docker build -t exec-form .
```

And run it

```bash
$ docker run --rm -d --name exec-form exec-form
```

Check processes inside exec-form container

```bash
$ docker exec -it exec-form ps x
  PID TTY      STAT   TIME COMMAND
    1 ?        Ssl    0:00 node app.js
   12 pts/0    Rs+    0:00 ps x
```

As you can see, it runs the node process directly (not inside a shell).

Changing the ENTRYPOINT to shell form

```diff
- ENTRYPOINT ["node", "app.js"]
+ ENTRYPOINT node app.js
```

And check its processes again

```bash
$ docker exec -it shell-form ps x
  PID TTY      STAT   TIME  COMMAND
  1   ?        Ss     0:00  /bin/sh -c node app.js
  6   ?        Sl     0:00  node app.js
  13  pts/0    Rs+    0:00  ps x
```

In that case, the main process (PID 1) would be the shell process instead of node process. the node process (PID 6) would be started from that shell.

The shell process is unecessary, which is why you should always use the exec form of the `ENTRYPOINT` instruction.
