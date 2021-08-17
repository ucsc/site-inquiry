---
layout: brief
issue: 2021
category: brief
order: 2
title: Watching the clock
author:
  last: Welsh
colors:
    tag: "#84cbd8"
tags:
    - Chemistry and Biochemistry
---
A ubiquitous blue-green bacteria found in ponds and lakes worldwide may provide the key to unlocking how life on Earth keeps track of day and night. These [cyanobacteria](https://www.sciencedirect.com/topics/agricultural-and-biological-sciences/cyanobacteria) &#8212; single-celled, microscopic organisms that create energy from sunlight &#8212; provide a simple system that Professor [**Carrie Partch**](https://www.chemistry.ucsc.edu/about/directory-page.php?uid=cpartch) and her collaborators have harnessed to better probe the intricate workings of [biological clocks](https://www.nigms.nih.gov/education/fact-sheets/Pages/circadian-rhythms.aspx), the molecular machines that keep time in all living organisms.

<figure class="right" style="width:900px">
  {% asset 2021/cyanobacteria-bloom.jpg @magick:resize=900 alt:'Cyanobacteria bloom' %}<figcaption markdown="span">These images show cyanobacteria blooming in a freshwater pond, as commonly encountered (left), at low resolution under the microscope (middle), and at higher resolution (right), revealing how each "string" consists of individual cyanobacteria linked together in tangled, single-cell filaments. Professor of chemistry and biochemistry Carrie Partch and her team work with the cyanobacteria species *Synechococcus elongatus*; its simple biological clock provides an exceptional experimental model for understanding the fundamental principles of how circadian rhythms work on the molecular level. Credits: [Christian Fischer](https://commons.wikimedia.org/wiki/File:Cyanobacteria_Aggregation1.jpg); [Josef Reischig](https://commons.wikimedia.org/wiki/File:Cyanobacteria_(248_08)_Mixture;_native_preparation;_green_filter.jpg); [Josef Reischig](https://commons.wikimedia.org/wiki/File:Cyanobacteria_(248_07)_Mixture;_native_preparation;_green_filter.jpg) (all CC BY-SA 3.0).
  </figcaption>
</figure>

The cyanobacterial clock, one of the most ancient on Earth, ticks in rhythm with each day, crucially triggering the generation of energy from sunlight during the day and then tripping the switch to use that energy in the dark. The goal of the [Partch lab](https://www.partchlab.com/)'s cyanobacteria research is to reveal, on a molecular level, how this rudimentary clock encodes its timing, how it aligns itself with its environment, and how it communicates time to other parts of the cell.

In a recent [report](https://www.biorxiv.org/content/10.1101/2020.06.18.158576v1) in the prestigious journal *Science*, the researchers detail their success in recreating the cyanobacterial clock protein-by-protein in a test tube. By letting them perform straightforward experiments not previously possible, the model system is allowing them to [uncover new steps in the molecular transformations that keep the clock ticking. "The cyanobacterial clock," Partch said, "is helping us understand the general principles that make a biological clock."](https://www.partchlab.com/)

{% assign last = site.data.contributors[page.author.last] %}
{% assign contrib = site.data.contributors | where:"last", page.author.last | first %}
{% if contrib.url %}
*&mdash;[{{ contrib.first }} {{contrib.last}}]({{ contrib.url }})*
{% else %}
*&mdash;{{ contrib.first }} {{ contrib.last }}*
{% endif %}