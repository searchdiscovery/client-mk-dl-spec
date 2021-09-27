## customEvent - Size Selection on PDP, QV
Executed anywhere the user chooses to select the size of a product. This can happen from product detail pages and quickview pages on the site.

```javascript
// Create object with eventInfo and product object
var ddSizeSelectionEvent = {
  eventInfo: {
    eventName: "sizeSelection",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // Use an array even though this will most likely always be a single item
    {
      availability: "y",
      basePrice: "145.0",
      colorCode: "BLACK",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      pricePer: "145.0",
      priceType: "List",
      productID: "831879309",
      sizeCode: "LARGE",
      upc: "888318793094"
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddSizeSelectionEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("sizeSelection");
```

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|availability|string|Whether or not the item is in stock|`"y"`, `"n"`|||||||
|basePrice|float|Base price of the item|`145.0`|||||||
|colorCode|string|Color code|`"BLACK"`|||||||
|mfr|string|Manufacturer of the item|`"Michael Kors"`|||||||
|mfrItemNum|string|ID used by manufacturer|`"CB99A5G0UK"`|||||||
|pricePer|float|Displayed unit price of item||||||||
|priceType|string|Type of price displayed to user|`"Markdown"`|||||||
|productID|string|Product ID|`"4952115"`|||||||
|sizeCode|string|Size code|`"LARGE"`|||||||
|upc|string|Universal purchase code ID|`"888318793094"`|||||||