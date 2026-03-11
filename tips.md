---
title: Useful tips
sidebar: mydoc_sidebar
permalink: /tips.html
toc: true
---

## Animation preferences

The [interactive debugging](/execute.html#interactive-debugging) and [automatic execution](/execute.html#automatic-execution) shown in Step 5 rely on the animation capabilities of [**ProB**](https://prob.hhu.de). ProB allows you to configure its behavior through preference definitions added to the B machine.

These options influence how execution is explored, how values are displayed, and how invariant properties are checked during animation. For example:

<pre>
DEFINITIONS
    SET_PREF_MAX_OPERATIONS == 1 ;
    SET_PREF_SHOW_EVENTB_ANY_VALUES == TRUE ;
    SET_PREF_INVARIANT_CHECKING == TRUE ;
    SET_PREF_MAXINT == 100 ;
</pre>

- `SET_PREF_MAX_OPERATIONS == 1`  
  Limits the number of enabled operations shown at each animation step. This is especially useful for interactive debugging of transformations and also speeds up automatic execution, since ProB does not compute all possible enabled operations at once.

- `SET_PREF_SHOW_EVENTB_ANY_VALUES == TRUE`  
  Displays the concrete values chosen for variables introduced by `ANY` substitutions. This helps understand how ProB resolves non-deterministic choices during execution.

- `SET_PREF_INVARIANT_CHECKING == TRUE`  
  Forces ProB to check invariants after each executed operation. This option can be disabled (`FALSE`) if the B specification has already been fully proved (for example using Atelier B), which may improve performance.

- `SET_PREF_MAXINT == 100`  
  Sets the maximum integer bound used by ProB during animation. Increasing this value may be necessary when models manipulate integers outside the default range.

{% include tip.html content="For interactive debugging, it is recommended to keep the number of enabled operations small and to enable invariant checking, so that the execution trace remains easy to understand and correctness violations are detected immediately." %}

## Defining value domains for animation

{% include callout.html content="For the transformation to execute correctly, ProB must be able to construct a **sufficient data set** for all abstract sets used in the B machine." type="primary" %} 



In our example, the values of set `MEMBER` are derived from the input model. Therefore, the cardinality of `MEMBER` is known from the beginning of the animation.

Since the transformation is expected to create one `PERSON` for each `MEMBER`, ProB must evaluate `MEMBER` first so that it can construct a compatible domain for `PERSON`. For this reason, `PERSON` must be declared **after** `MEMBER`.

If `PERSON` is declared independently without sufficient constraints, ProB may fail to generate enough elements to support the creation of output instances. In such a case, animation may stop prematurely without ensuring completeness.

To ensure that the output domain is large enough, the cardinality of `PERSON` has been constrained to match the input domain:

<pre>card(PERSON) = card(MEMBER)</pre>

{% include tip.html content="In practice, ProB behaves as a constraint solver: it computes valuations of abstract sets that satisfy all properties and invariants. By linking the cardinalities of input and output sets, you guarantee the **completeness of the animation** and the successful execution of the transformation.." %}



## Meta-model annotation

TO DO

## Formatting an Xtext DSL

TO DO