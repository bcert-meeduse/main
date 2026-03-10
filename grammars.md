---
title: Create Xtext grammars
sidebar: mydoc_sidebar
permalink: /grammars.html
toc: true
---

This tutorial explains how to create **Xtext grammars** that can be used with **BCerT**.  

## Step 1 — Create an Xtext project

1. Open **Eclipse**
2. Go to **File → New → Project**
3. Select **Xtext Project**
4. Click **Next**

5. Fill the following information:
  - `Project name`
  - `Language name`
  - `File extension`

{% include callout.html content="Example: define two languages `org.xtext.families` (with extension `.fam`) and `org.xtext.persons` (with extension `.per`)." type="primary" %} 

Click **Finish**. Xtext will generate the following components:

- the **grammar definition**
- the **parser**
- the **EMF metamodel**
- the **editor**

## Step 2 — Define the grammar

Edit the `.xtext` file located in the project. 

{% include callout.html content="The screenshot below shows the two grammars that are considered in the next steps of the user's guide.
" type="primary" %} 


{% include image.html file="xtext.png" max-width="850"%}

{% include tip.html content="Make sure the axiom of your output grammar creates a root model element (e.g. PersonModel:{PersonModel}). BCerT uses this root element as the entry point when generating output models." %}


## Step 3 — Generate the Xtext artifacts

Right-click on the `.xtext` grammar file and select: **Run As → Generate Xtext Artifacts**

Xtext generates the following elements automatically:

- an `.ecore` metamodel
- a corresponding `.genmodel` file

These files are created in the folder: `model/generated`

The `.ecore` file represents the meta-model derived from the grammar, while the `.genmodel` file is used to generate the EMF infrastructure.

For each generated `.genmodel` file:

1. Open the file
2. Right-click on the **root element** of the file
3. Select **Generate Edit Code**

This step generates the EMF editing support required by BCerT.

{% include image.html file="genmodel.png" max-width="850"%}