---
title: Define the transformation in B
sidebar: mydoc_sidebar
permalink: /transformation.html
toc: true
---

## Step 1 — Apply constants to input models

{% include tip.html content="This step is useful if your input model is not expected to change during the transformation. Skip this step if you are modeling bi-directional transformations where modifications may be applied to both source and target models." %}

1. Open the file `pivot.ecore`.

2. Expand the model as shown in the screenshot below.

3. Right-click on the root package of the **target meta-model**  
   (`families.ecore` in this example).

4. Select **Patch with constants**.

5. Click on **Ok**

<center>
{% include image.html file="constants.png" max-width="850" %}
</center>

## Step 2 — Generate B Data Structures

1. Right-click on the file `pivot.ecore` in the **Model Explorer**.

2. Select **Meeduse: Extract B models**.

<center>
{% include image.html file="generate.png" max-width="850" %}
</center>

{% include callout.html content="The extraction of B models is the backbone of the Meeduse tool. It generates three files: `pivot.ecore.bmethod`, `pivot.ecore.uml`, and `pivot.mch`. The latter is a B machine whose data structures represent the structural features of the involved meta-models. Its operations define setters, getters, and the creation or deletion of model elements. Inspect this file to understand how Meeduse translates meta-models into B." type="primary" %}

### Meta-models space as abstract SETS

<pre>
MACHINE pivot

SETS
    FAMILY;
    MEMBER;
    FAMILYMODEL;
    PIVOT;
    PERSON;
    PERSONMODEL
</pre>

### Input model elements as CONSTANTS

<pre>
CONSTANTS
    Family,
    Member,
    FamilyModel,
    families_PersonModel,
    lastName,
    firstName,
    A_theMother_family,
    A_theFather_family,
    A_daughters_family,
    A_sons_family,
    A_families_personModel

PROPERTIES
    Family : FIN(FAMILY) &
    Member : FIN(MEMBER) &
    FamilyModel : FIN(FAMILYMODEL) &
    families_PersonModel <: FamilyModel &
    lastName : Family +-> STRING &
    firstName : Member +-> STRING &
    A_theMother_family : Family >+> Member &
    A_theFather_family : Family >+> Member &
    A_daughters_family : Member +-> Family &
    A_sons_family : Member +-> Family &
    A_families_personModel : Family +-> families_PersonModel
</pre>

### Output model elements as VARIABLES

<pre>
VARIABLES
    Pivot,
    Person,
    persons_PersonModel,
    Male,
    Female,
    A_families_pivot,
    A_persons_pivot,
    A_persons_personModel,
    name

INVARIANT
    Pivot : FIN(PIVOT) &
    Person : FIN(PERSON) &
    persons_PersonModel : FIN(PERSONMODEL) &
    Male <: Person &
    Female <: Person &
    A_families_pivot : Pivot --> FamilyModel &
    A_persons_pivot : Pivot --> persons_PersonModel &
    A_persons_personModel : Person +-> persons_PersonModel &
    name : Person <-> STRING &
    Male /\ Female = {}
</pre>

## Step 3 — Specify the transformation in B