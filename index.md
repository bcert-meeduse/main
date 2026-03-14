---
keywords: BCerT, B, certification, model transformation, transpiler
sidebar: mydoc_sidebar
permalink: index.html
toc: false
---
<img src="{{ "images/BCertComplet.png" }}" class="logo"/>

**BCerT** is an Eclipse-based MDE tool dedicated to the formal specification, verification, and execution of **model-to-model transformations** and **grammar-to-grammar transpilers** using the B method. It supports transformations for **Ecore metamodels** and **Xtext grammars**. 

{% include note.html content="The public version of BCerT currently supports **Classical B** as well as the **B System** dialect of **Event-B** used in Atelier B. The integration of the Rodin format of Event-B is under experimentation and will be available in a future release." %}
<center>
<img src="{{ "/images/bcert-architecture.svg" | relative_url }}">
</center>

## Features

<!--- **Formal specification:** Transformations are specified using **B operations**, providing a precise and executable formal semantics.

- **Formal verification:** Transformation specifications can be **formally analysed and proven** using B verification tools.-->

- **Execution:** Formal B specifications of the transformation can be executed on **concrete models**, producing target models while preserving invariant properties.

- **Step-by-step debugging:** BCerT integrates with <a href="https://vasco.imag.fr/tools/meeduse/" target="_blank">**Meeduse debugging facilities**</a>, allowing developers to execute transformations step by step and inspect intermediate states.

- **Trace replay:** Replays (backward and foreward) execution traces so that transformation logic  can be understood.

- **Batch transformation runner:** Transformations can be executed on **multiple models** at once using sequential execution or parallel execution for improved performance on large model collections.

👉 **[Installation guide]({{ "/install.html" | relative_url }})**

## License

BCerT is distributed under the **Eclipse Public License v2.0 (EPL-2.0)**.

<div style="background:#f8f8f8; border-left:5px solid #347DBE; padding:12px; margin:12px 0; font-size:95%;">

<strong>Eclipse Public License — v 2.0</strong><br><br>

THE ACCOMPANYING PROGRAM IS PROVIDED UNDER THE TERMS OF THIS  
ECLIPSE PUBLIC LICENSE ("AGREEMENT"). ANY USE, REPRODUCTION OR  
DISTRIBUTION OF THE PROGRAM CONSTITUTES RECIPIENT'S ACCEPTANCE  
OF THIS AGREEMENT.

<br>

<a href="https://www.eclipse.org/legal/epl-2.0/" target="_blank" rel="noopener">
View the full license text
</a>

</div>