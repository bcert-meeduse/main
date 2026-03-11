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

5. Click on **Ok**.

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
    card(PERSON) = card(MEMBER) & /* ensures completeness */
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

{% include warning.html content="Be sure that set PERSON is declared after set MEMBER, and add predicate card(PERSON) = card(MEMBER) to the PROPERTIES clause as presented above." %}

### Output model elements as VARIABLES

<pre>
VARIABLES
	Pivot,
	Person,
	PersonModel,
	Male,
	Female,
	A_families_pivot,
	A_persons_pivot,
	A_persons_personModel,
	name

INVARIANT
	Pivot : FIN(PIVOT) &
	Person : FIN(PERSON) &
	PersonModel : FIN(PERSONMODEL) &
	Male <: Person &
	Female <: Person &
	A_families_pivot : Pivot --> FamilyModel &
	A_persons_pivot : Pivot --> PersonModel &
	A_persons_personModel : Person +-> PersonModel &
	name : Person <-> STRING &
	Female /\ Male = {}
</pre>

## Step 3 — Specify the transformation in B

1. Right click on folder `model` of your transformation project.
2. Select **New → File**
3. Name the file. For example `transformation.mch`

<center>
{% include image.html file="file.png" max-width="850" %}
</center>


{% include callout.html content="
There are several strategies for specifying transformations in B. In this tutorial we use the inclusion principle of Classical B in order to reuse the utility operations defined in the `pivot` machine.

Note that B is not a programming language. A recommended approach is to first think about the properties that the transformation must guarantee before considering how the transformation should be implemented.

Below is an example of the content of the file `transformation.mch`.
" type="primary" %}

<pre>
MACHINE     transformation
INCLUDES    pivot
DEFINITIONS
    familyOf == A_daughters_family 
                \/ A_sons_family 
                \/ A_theMother_family~ 
                \/ A_theFather_family~ ;
    isFemale(self) == self : dom(A_daughters_family ) \/ ran(A_theMother_family) ;
PROPERTIES
    familyOf : Member --> Family      /* a member must be in one family */
    & lastName : Family --> STRING      /* lastName is mandatory */
    & firstName : Member --> STRING     /* firstName is mandatory */
VARIABLES
    mapped  /* for traceability */
INVARIANT
    mapped : Person >-> Member  
    & mapped[Male]      <: dom(A_sons_family) \/ ran(A_theFather_family)
    & mapped[Female]    <: dom(A_daughters_family ) \/ ran(A_theMother_family)
    & A_persons_personModel : Person --> PersonModel    /* a person must belong to a Person Model */
    & dom(name) = Person                                /* person name is mandatory */
INITIALISATION
    mapped := {}
OPERATIONS
Member2Person =
    ANY aMember, aPerson, pModel WHERE
        aMember : Member & aMember /: ran(mapped) &
        aPerson : PERSON & aPerson /: Person &
        pModel : PersonModel
    THEN
        IF isFemale(aMember) THEN
            Female_NEW(aPerson)
        ELSE
            Male_NEW(aPerson)
        END ;
        SetName(aPerson, {firstName(aMember), lastName(familyOf(aMember))});
        AddPersons(pModel, aPerson);
        mapped := mapped \/ {(aPerson |-> aMember)}
    END
END
</pre>