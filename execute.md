---
title: Execute the transformation
sidebar: mydoc_sidebar
permalink: /execute.html
toc: true
---

Step 4 generated a Modeling project in the Eclipse run-time that contains, for every input model `xxx.fam`:

- `xxx.per` — an empty output file
- `xxx.pivot` — an instance of the pivot meta-model mapping the input model to the output model

{% include image.html file="menu.png"%}

## Debugging the transformation

- Right click on the root entry of a `.pivot`file
- Select **Execute model --> transformation.mch**
- Click on **Finish**
{% include image.html file="debug.png"%}