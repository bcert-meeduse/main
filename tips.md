---
title: Useful tips
sidebar: mydoc_sidebar
permalink: /tips.html
toc: true
---

## Animation/Execution preferences

{% include callout.html content="The [interactive debugging](/execute.html#interactive-debugging) and [automatic execution](/execute.html#automatic-execution) shown in Step 5 rely on the animation capabilities of [**ProB**](https://prob.hhu.de). ProB allows one to configure its behavior directly in the B machine through  definitions." type="primary" %} 

The commonly used ProB preferences in BCerT are:

<pre>
DEFINITIONS
    SET_PREF_MAX_OPERATIONS == 1 ;
    SET_PREF_SHOW_EVENTB_ANY_VALUES == TRUE ;
    SET_PREF_INVARIANT_CHECKING == TRUE ;
    SET_PREF_MAXINT == 100 ;
    SET_PREF_DEFAULT_SETSIZE == 10 ;
</pre>

- `SET_PREF_MAX_OPERATIONS == 1`  
  Limits the number of enabled operations shown at each animation step. This is especially useful for interactive debugging of transformations and also speeds up automatic execution, since ProB does not compute all possible enabled operations at once.

- `SET_PREF_SHOW_EVENTB_ANY_VALUES == TRUE`  
  Displays the concrete values chosen for variables introduced by `ANY` substitutions. This helps understand how ProB resolves non-deterministic choices during execution.

- `SET_PREF_INVARIANT_CHECKING == TRUE`  
  Forces ProB to check invariants after each executed operation. This option can be disabled (`FALSE`) if the B specification has already been fully proved (for example using Atelier B), which may improve performance.

- `SET_PREF_MAXINT == 100`  
  Sets the maximum integer bound used by ProB during animation. Increasing this value may be necessary when models manipulate integers outside the default range.

- `SET_PREF_DEFAULT_SETSIZE == 10`  
  Defines the default cardinality used by ProB for abstract sets. This is important since animation requires a finite domain for each abstract set.

{% include tip.html content="For interactive debugging, it is recommended to keep the number of enabled operations small and to enable invariant checking, so that the execution trace remains easy to understand and correctness violations are detected immediately." %}

## Solving value domains for abstract sets

{% include callout.html content="For the transformation to execute correctly, ProB must be able to construct a **sufficient data set** for all abstract sets used in the B machine. One way to achieve this is to use a large fixed domain via `SET_PREF_DEFAULT_SETSIZE`. Another recommended approach is to relate the cardinalities of abstract sets coming from input and output models." type="primary" %} 

In our example, the values of set `MEMBER` are derived from the input model. Therefore, the cardinality of `MEMBER` is known from the beginning of the animation.

Since the transformation is expected to create one `PERSON` for each `MEMBER`, ProB must evaluate `MEMBER` first so that it can construct a compatible domain for `PERSON`. For this reason, `PERSON` must be declared **after** `MEMBER`.

To ensure that the output domain is large enough, the cardinality of `PERSON` is constrained to match the cardinality of `MEMBER`:

<pre>
PROPERTIES
    card(PERSON) = card(MEMBER)
</pre>

{% include tip.html content="In practice, ProB behaves as a constraint solver: it computes valuations of abstract sets that satisfy all properties and invariants. By linking the cardinalities of input and output sets, you guarantee the **completeness of the animation** and the successful execution of the transformation." %}

## Meta-model annotation

TO DO

## Formatting an Xtext DSL

TO DO