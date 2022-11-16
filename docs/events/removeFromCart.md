---
title: Remove From Cart
---

# Remove from Cart
Executed only when the user initially completely removes item(s) from the cart. This can happen from the cart by clicking remove or as a result of a quantity update on the shopping cart page. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a cart remove and a cart add.

## Code Example

```javascript
// create object with eventInfo and product object
var ddRemoveFromCartEvent = {
  eventInfo: {
    eventName: "removeFromCart",
    type: "cart",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      basePrice: 145.0,
      customized: true,
      gwp: "N",
      gwpSku: "",
      upc: "888318793094",
      isBaseItem: true,
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      outfitID:  "28415181",
      pricePer: 145.0,
      priceType: "list",
      productID: "831879309",
      quantity: 2
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromCartEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('removeFromCart');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"removeFromCart"`|
|type|string|Yes|The event type|`"cart"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|customized|boolean|Yes|Whether or not the item has been customized|`false`
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isBaseItem|boolean|Yes|Whether or not the item is the base item|`true`, `false`|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|outfitID|string|If available|Outfit ID|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|size|string|Only if product has a size choice|Size code|`"large"`, `"12"`|
|upc|string|Yes|Universal purchase code ID|