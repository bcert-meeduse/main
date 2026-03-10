---
title: Create a transformation project
sidebar: mydoc_sidebar
permalink: /bcert_project.html
toc: false
---

In Eclipse:

- Go to **File → New → Other**

<center>
{% include image.html file="other.png" max-width="850"%}
</center>

- Select: BCerT → **Create transformation project**

- Click **Next**

- Enter the **name of the transformation project**. For example: `pivot`

{% include tip.html content="The project name (here `pivot`) is important because **BCerT automatically creates an Ecore package with this name**. The package will contain the transformation elements required for the next steps." %}

- Click **Next**.

- Add the `.ecore` files of your **input** and **output** languages.  
  For example: `Families.ecore` and `Persons.ecore`. These files are typically located in: `model/generated` 

<center>
{% include image.html file="chooseecore.png" max-width="850"%}
</center>

- Click **Next**.

- Select the **root class** for each metamodel. In our example:

  - `FamilyModel` for the **Families** metamodel  
  - `PersonModel` for the **Persons** metamodel

<center>
{% include image.html file="root.png" max-width="850"%}
</center>

- Click **Finish**. BCerT creates a new **Ecore project** containing two files: `pivot.ecore` and `pivot.genmodel`

- Open the file `pivot.genmodel`

- Right-click on the **root element** and generate the EMF code:

  - Generate Model Code
  - Generate Edit Code
  - Generate Editor Code

<center>
{% include image.html file="pivot.png" max-width="850" %}
</center>

{% include callout.html content="This step generates the **EMF model implementation**, the **editing support**, and the **Eclipse editor** for the pivot metamodel used by the transformation." type="primary" %} 

