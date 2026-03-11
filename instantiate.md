---
title: Execute the transformation
sidebar: mydoc_sidebar
permalink: /instantiate.html
toc: true
---

## Step 1 — Run Eclipse run-time

1. Right-click on your transformation project (here `pivot`)
2. Select **Run As → Eclipse Application**

This launches a new Eclipse instance (called *Eclipse run-time*).

<center>
{% include image.html file="runtime.png" %}
</center>

## Step 2 — Create a project

1. In the Eclipse run-time, go to **File → New → Project**
2. Select **General → Project**
3. Click **Next**
4. Enter a project name (for example `Families`)
5. Click **Finish**

## Step 3 — Create input models

6. Right-click on project `Families` → **New → File**
    <center>
    {% include image.html file="create.png" %}
    </center>
7. Enter a file name (for example `addams.fam`)
8. Xtext will prompt you to convert project `Families` into an Xtext project — click **Yes**
9. Edit file `addams.fam` with a valid model conforming to the grammar.

In the example below, two families are defined in two different files.

<center>
{% include image.html file="families.png" %}
</center>

## Step 4 — Instantiate the transformation project

- In the Eclipse run-time, go to **File → New → Other...**
- Under **BCerT**, choose **Generate transformation instance**
<center>
{% include image.html file="instanciate.png" %}
</center>
- Select the `pivot` meta-model in the list (you can use the search field)
- Enter a name for the transformation instance  
  (you can keep `pivot`; in this example we use `Families2Persons`)
<center>
{% include image.html file="select.png" %}
</center>
- Click **Next**
- Select the source meta-model (in this example: `families : families`)
- Specify the output file extension  (in this example: `per`)
- In the file list, select the input models to transform and add them to the selection
<center>
{% include image.html file="inout.png" %}
</center>
- Click **Finish** to generate the transformation instance