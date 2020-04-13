---
layout: post
title: "OAuth work flow"
categories: oauth, "back to basic"
---

### Step 1
The user selects the provider with whom they wish to sign in to the client app.

### Step 2
The user is redirected to the provider's website (with a URL that includes the `client app id`, where they are asked to give permission to the client app.

### Step 3
The user signs in from the OAuth service provider and accepts the permissions requested by the third-party application.

### Step 4
The user is redirected to the client app with the `request code`
 
### Step 5
The the background, the client sends the grant code to the provider, who sends back an `authentication token`

### Step 6
The client app uses the `access token` to make authorized request to the provider, such as to get user information or wall posts.
