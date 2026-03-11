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

## Interactive debugging

1. Open a `.per` file to observe its content during debugging.

2. Right-click on the root entry of the corresponding `.pivot` file in the Model explorer.

    <center>
    {% include image.html file="debug.png" %}
    </center>

3. Select **Execute model → transformation.mch**

4. Click **Finish**

5. The Meeduse debugging views are opened:

   - **Execution View** — lists the executable operations of the transformation  
   - **State View** — shows the current values of variables  

   Double-click an operation in the Execution View (e.g., `Member2Person()`) to execute one step of the transformation.  
   The output model is updated and the invariant is verified at every step.

    <center>
    {% include image.html file="views.png" %}
    </center>

    {% include callout.html content="For more information about the debugging features of Meeduse please refer to the documentation of Meeduse." type="primary" %}

## Automatic execution

