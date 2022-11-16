---
title: Quick View
---

## Quick View

Executed when a quick view dialog is displayed. Since a new page is not loaded when this happens, we need to put the product information into the data layer and dispatch an event to let Launch know about it.

## JavaScript Code

```javascript
// Create object with eventInfo and product object
var ddQuickViewEvent = {
  eventInfo: {
    eventName: "quickView",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // array of product objects
    {
      basePrice: 445.0,
      categoryID: "cat20099",
      categoryName: "NEW ARRIVALS",
      customized: false,
      gwp: "N",
      gwpSku: "",
      mfr: "Michael Kors Studio",
      mfrItemNum: "30H6SOAL2L",
      pricePer: 598.0,
      priceType: "Markdown",
      productID: "4952115",
      upc: "190049521151"
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddQuickViewEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('quickView');
```

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|float|Base unit price of item|`445.0`|||||||
|categoryID|string|SFCC category ID|`"cat20009"`|||||||
|categoryName|string|Name of category|`"NEW ARRIVALS"`|||||||
|customized|boolean|Whether or not the item has been customized|`true`, `false`|||||||
|gwp|string||`"N"`|||||||
|gwpSku|string|||||||||
|mfr|string|Manufacturer of the item||||||||
|mfrItemNum|string|ID used by manufacturer||||||||
|pricePer|float|Displayed unit price of item||||||||
|priceType|string|Type of price displayed to user|`"Markdown"`|||||||
|productID|string|Product ID|`"4952115"`|||||||
|upc|string|Universal purchase code ID||||||||
