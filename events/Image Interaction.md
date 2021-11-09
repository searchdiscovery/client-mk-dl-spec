# Image Interaction
Executed on a product detail page and quick view when the user interacts with the different image actions.

## Code Example

```javascript
//create object with eventInfo and product object
var ddImageInteractionEvent = {
  eventInfo: {
    eventName: "imgInteraction",
    interactionType: "zoom",
    type: "product interaction",    
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      availability: true,
      basePrice: 98.00,
      color: "TRUE NAVY",
      mfr: "MICHAEL Michael Kors",
      mfrItemNum: "MF98Z5M65N",
      pricePer: 98.00,
      priceType: "list",
      productID: "831879309",
      size: "small",
      upc: "888318793094"
    }
  ]
};

//Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddImageInteractionEvent);

//Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("ddImageInteractionEvent");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"errorEvent"`|
|interactionType|string|If available|The type of interaction triggering the event|`"zoom"`|
|type|string|Yes|The event type|`"customer facing error"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|availability|boolean|If available|Whether or not the product is available for purchase|`true`, `false`|
|basePrice|number|Yes|Base unit price of item|`445.00`|
|color|string|Only if the product has a color choice|Color code|`"black"`|
|mfr|string|Yes|Manufacturer of the item|`"MICHAEL KORS"`|
|mfrItemNum|string|Yes|ID used by manufacturer|`"30H6GRXE3L"`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|size|string|Only if product has a size choice|Size code|`"large"`, `"12"`|
|upc|string|Yes|Universal purchase code ID|