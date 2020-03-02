---
layout: post
title: "2020 Reading list"
categories: reading
---

# January
- [Don't Work Alone When You're a New or Junior Engineer](https://blog.pragmaticengineer.com/dont-work-alone/)

> Make sure non-senior engineers don't work completly alone, no matter how small the project at hand is.

> Ask another engineer on your team to be your buddy for the project, do a quick check-in with you everyday, and reviewing your planning and doing code reviews.

# March
- [Links to cross-origin destination are unsafe](https://web.dev/external-anchors-use-rel-noopener/)

When you link to a page on another site using the `target="_blank"` attribute, you can expose your site to performance and security issues:

- The other page may run on the same process as your page. If the other page is running a lot of JS, your page's performance may suffer
- The other page can access your `window` objevt with the `window.opener` property. This may allow the other page to redirect your page to a malicious URL

```html
<a href="https://examplepetstore.com" target="_blank" rel="noopener">Example Pet Store</a>
```

- `rel="noopener"` prevents the new page from being able to access the `window.opener` property and ensures it runs in a separate process.
- `rel="noreferrer` has the same effect but also prevents the `Referer` header from being sent to the new page.
