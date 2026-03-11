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

1. Open a `.per` file to see its content during the debugging 
2. Right click on the root entry of the corresponding `.pivot`file
3. Select **Execute model --> transformation.mch**
4. Click on **Finish**
    {% include image.html file="debug.png"%}
5. This opens the debugging views of Meeduse: **Execution view** and **State View**
    {% include image.html file="views.png"%}