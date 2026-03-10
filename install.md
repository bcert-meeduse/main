---
title: Installation
sidebar: mydoc_sidebar
permalink: /install.html
toc: false
---

## Prerequisites

- Donwload <a href="https://www.eclipse.org/downloads/packages/release/2025-12/r/eclipse-modeling-tools" target="_blank">**Eclipse Modeling Tools**</a>
- Be sure that your Eclipse is be equipped with **Java 17** (or later)
- Install Xtext via the marketplace **Help → Eclipse Marketplace... → Xtext**

{% include callout.html content="We recommend using the latest **Eclipse Modeling** distribution." type="primary" %} 


## Update sites

BCerT depends on <a href="https://vasco.imag.fr/tools/meeduse/" target="_blank" rel="noopener">Meeduse</a> and <a href="http://vasco.imag.fr/tools/b4msecure/" target="_blank" rel="noopener">B4MSecure</a>.   These two dependencies must be installed.

- **B4MSecure** update site: `http://vasco.imag.fr/tools/b4msecure/updates/build`
- **Meeduse** update site: `http://vasco.imag.fr/tools/meeduse/updates/build`
- **BCerT** update site: `https://bcert-meeduse.github.io/build`

## Installation details

1. Open **Eclipse**
2. Go to **Help → Install New Software**
3. Add the **B4MSecure update site**
4. Add the **Meeduse update site**
5. Add the **BCerT update site**
6. Select **BCerT**
7. Click **Next**
8. Complete the installation wizard
9. Restart Eclipse when prompted

For general instructions on installing software from update sites, refer to the
<a href="https://help.eclipse.org/latest/topic/org.eclipse.platform.doc.user/tasks/tasks-127.htm?cp=0_3_22_3" target="_blank" rel="noopener">Eclipse documentation</a>.

## Installed plugins

Installing BCerT adds the following plugins to Meeduse:

- `fr.meeduse.ecore.m2mwizard`
- `fr.meeduse.ecore.rootgenerator`
- `fr.meeduse.ecore.runner`

<div id="bcert-stats">Loading BCerT installation count...</div>
<script>
fetch("https://update.bcert-meeduse.workers.dev/stats")
  .then(response => response.json())
  .then(data => {
    document.getElementById("bcert-stats").innerHTML =
      "BCerT installations: <b>" + data.installs + "</b>";
  })
  .catch(error => {
    document.getElementById("bcert-stats").innerText =
      "BCerT installation count unavailable.";
    console.error(error);
  });
</script>
