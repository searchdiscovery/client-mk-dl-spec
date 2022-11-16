---
title: Color Selection
---

## Color Selection
Executed anywhere the user chooses to select the color of a product. This can happen from product detail pages and quickview pages on the site today (non-responsive site).

```javascript
// Create object with eventInfo and product object
var ddColorSelectionEvent = {
  eventInfo: {
    eventName: "colorSelection",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // Use an array even though this will most likely always be a single item
    {
      colorCode: "BLACK",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      productID: "831879309",
      upc: "888318793094"
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddColorSelectionEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("colorSelection");
```

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|colorCode|string|Color code|`"BLACK"`|||||||
|mfr|string|Manufacturer of the item|`"Michael Kors"`|||||||
|mfrItemNum|string|ID used by manufacturer|`"CB99A5G0UK"`|||||||
|productID|string|Product ID|`"4952115"`|||||||
|upc|string|Universal purchase code ID|`"888318793094"`|||||||
