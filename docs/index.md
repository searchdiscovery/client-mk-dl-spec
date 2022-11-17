---
title: Home
hide:
  - navigation
  - toc
---

![SDI logo](https://lh5.googleusercontent.com/qISy6cadFd9w5RbPc1eqZj7SISc844g8KRXSeM2P07h1PvkDJbpVtE--xNttLLSvlklK7e5dr52fGGuTGQZ19CqrLeg0dr7UuisKnKUK0xxs6IP8LfnsPMkBkfLeQfUMABH-cJn7=s0)

# Data Layer Technical Specification

## Overview
This document outlines the specific changes requested of Michael Kors IT/Dev to implement events using Digital Data layer and to begin leveraging Launch for event tagging.

**NOTE:** The object examples provided in this document should be functional, but it’s highly recommended that they not be copied and pasted. The apostrophes can be unusable when copied and pasted.

An assumption has also been made that there is already a data layer implemented according to the data layer documentation. As a result, this document is only focused on the event object and utilizing custom browser events to notify Launch that an event has occurred.

## Data Layer Rendering and Timing Considerations
Where on the page should the data layer go and how should it be implemented? The general answer to this question is, “As close to the top of the document as possible, before the Adobe Launch embed, ideally within the `<head>` and as JavaScript within an inline `<script>` tag”. The broader answer is that the `mkorsData` object should be implemented so that it can be referenced at window scope and so that the data that it provides is there before it is needed.

Any information that might be used by Adobe Launch as a rule condition should be rendered into the HTML page prior to the Adobe Launch header embed. This is typically the information in the `mkorsData.page` object as it is very common to set up rule conditions based on page type or category. Any information that is crucial for driving A/B testing or content targeting activities that need to happen as a part of page rendering should be included above the Adobe Launch header embed.

It is perfectly OK to build the `mkorsData` object in multiple inline scripts as long as the data provided is there before it is needed by Adobe Launch. This means that you can render some of it above the Adobe Launch header embed and another part just before the Adobe Launch synchronous footer call `_satellite.pageBottom()` before the closing `body` tag. Since the majority of analytics and marketing tags are Adobe Launch page bottom rules (triggered by the `_satellite.pageBottom()` call), as long as the info in the `mkorsData` object needed by these rules (product info, cart info, page info, etc) is populated before the `pageBottom` call, everyone will be happy. 

In some cases, it may be necessary to provide some static parts of the `mkorsData` object as part of cached components or cached HTML while providing other, more dynamic data via AJAX calls or similar technologies. This is often true of user profile information, or e-commerce cart info. In these cases, it’s just fine to populate the core of the `mkorsData` object from cached inline JS and the dynamic portions from asynchronous (or synchronous) request / responses.  The guidance still applies that the data must exist in the `mkorsData` object when or before Adobe Launch expects it to be there. In the case of data provided by asynchronous methods, we may need to have Adobe Launch wait for a notification before processing data. See [Custom Events](#custom-events) below for more on this.

If it is not possible to fully create the data layer prior to the Adobe Launch embed code, it is vital that the data layer is fully created prior to dispatching the `dataLayerReady` custom event found in the [customEvent - Data Layer Complete](#customevent--data-layer-complete) section towards the end of this document.