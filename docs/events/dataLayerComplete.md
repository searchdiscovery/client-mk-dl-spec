---
title: Data Layer Complete
---

# Data Layer Complete
This event will notify Adobe Launch that all applicable components of the data layer have fully loaded, so Adobe Launch will know it’s safe to start evaluating rules for sending analytics or marketing vendor data. This event should be dispatched on every page load, whether it is a “traditional” page load or a SPA page change.

## Code Example

The example below is just the event, and should be executed after any page load data layer scenarios have been instantiated on the page as normal.

```javascript
// data layer ready example
// assuming data layer object already exists and is populated with up to date information
window.mkorsData = {
  page: {/*...*/},
  user: [
    {/*...*/}
  ]
};

// Create and dispatch an event trigger
sendCustomEvent("dataLayerReady");
```