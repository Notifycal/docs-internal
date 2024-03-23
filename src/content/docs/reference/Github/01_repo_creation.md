---
title: Create a Github Repository
---

1. Go to the repository settings.
1. Uncheck _Allow merge commits_ and _Allow squash commits_.
1. Check _Always suggest updating pull request branches_.
1. Check _Automatically delete head branches_.
1. Set _Limit how many branches and tags can be updated in a single push_ to 5.

## Enable Github Actions access from other private repositories in the organziation

Do this if the repo is for example a TF module, or any other sort of repo that we'd want to access
from a Github Action without having to explicitly create and setup a PAT.

![Enable Org Private repo access](./images/actions_private_access_org.png)
