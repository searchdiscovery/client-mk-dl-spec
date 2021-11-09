# Quantity Selection
Executed on a product detail page and quick view when the user changes the quantity dropdown value.

## Code Example

```javascript
//create object with eventInfo and product object
var ddQtyChangeEvent = {
  eventInfo: {
    eventName: "qtyDropdownChange",
    selectionValue: "3",
    type: "product interaction",    
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false //Launch will change this to true once processed
    }
  },
  product: [ //use an array even though this will most likely always be a single item
    {
      availability: true,
      basePrice: 98.0,
      color: "TRUE NAVY",
      mfr: "MICHAEL Michael Kors",
      mfrItemNum: "MF98Z5M65N",
      pricePer: 98.0,
      priceType: "list",
      productID: "831879309",
      size: "S",
      upc: "888318793094"
    }
  ]
};

//Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddQtyChangeEvent);

//Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("ddQtyChangeEvent");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"qtyDropdownChange"`|
|selectionValue|number|Yes|The new value selected by the user|`3`|
|type|string|Yes|The event type|`"product interaction"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|availability|boolean|If available|Whether or not the product is available for purchase|`true`, `false`|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|color|string|Only if the product has a color choice|Color code|`"black"`|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|pricePer|number|Yes|Displayed unit price of item|`445.0`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|size|string|Only if product has a size choice|Size code|`"large"`, `"12"`|
|upc|string|Yes|Universal purchase code ID|