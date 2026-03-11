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
    {% include image.html file="debug.png" %}

3. Select **Execute model → transformation.mch**

4. Click **Finish**

5. The Meeduse debugging views are opened:

   - **Execution View** — lists the executable operations of the transformation  
   - **State View** — shows the current values of variables  
6. Double-click an operation in the **Execution View** (e.g., `Member2Person()`) to execute one step of the transformation.  
    The target file `.per` is updated and the invariant is verified at every step.

    {% include image.html file="views.png" %}

    {% include callout.html content="For more information about the debugging features of Meeduse, please refer to the official Meeduse documentation." type="primary" %}

    {% include callout.html content="Do not modify the file manually during interactive debugging. This will break the synchronization and you will need to restart from Step 1." type="danger" %}

    {% include callout.html content="When all model elements have been transformed, the State View displays Completed=TRUE." type="success" %}

## Automatic execution

1. Right click on project `Families2Persons` and select **Run transformation**

    {% include image.html file="autorun.png" %}

2. Choose the transformation machine `transformation.mch`

3. If you have many files to transform (i.e., several `.pivot` files inside project `Families2Persons`), select **Parallel** execution.  
   Otherwise, the transformation will be executed **sequentially**.

    {% include image.html file="report.png" %}

After execution, BCerT displays a detailed report including:

- execution status for each model  
- total number of transformed models  
- total transformation time  
- performance metrics  

The generated output models (`.per` files) are automatically updated.

