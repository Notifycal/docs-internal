---
title: Environments
description: Overview of infra environments
---

- `dev`
- `prod`


If in the future we want to create multiple dev environments, we can always use a new environment name, as long as it's free. We could potentially use the branch/or short commit sha for ephemeral environments (think of pre-merge testing): 

```
environment = "dev-5d2f3ab1"
```

To be able to do this, we need to be able to generate the TF remote state path based on the environment value.
