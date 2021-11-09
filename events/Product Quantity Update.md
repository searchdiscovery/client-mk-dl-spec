# Product Quantity Update
Executed when the user initially increases or decreases item(s) in their cart.  

This should not be called for the initial cart addition or a complete removal of the product from the cart. The add to cart and remove from cart events should continue to execute in those scenarios. 

## Code Example

```javascript
// create object with eventInfo and product object
var ddQtyUpdateEvent = {
  eventInfo: {
    eventName: "productQtyUpdate",
    type: "increase",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      basePrice: 145.0,
      customized: true,  
      engraved: true,
      gwp: "N", 
      gwpSku: "", 
      isBaseItem: true,   
      lookID: "",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      monogrammed: false,
      outfitID:	"28415181",
      pricePer: 145.0,
      priceType: "list", 
      productID: "831879309",
      quantity: 2,
      upc: "888318793094"
    }  
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddQtyUpdateEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('productQtyUpdate');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"productQtyUpdate"`|
|type|string|Yes|The event type|`"increase"`, `"decrease"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|
|engraved|boolean|If available|Whether or not the customer added an engraving|`true`, `false`|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isBaseItem|boolean||Whether the item is the base item|`true`, `false`|
|lookID|string|If available|Look ID|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|monogrammed|boolean|If available|Whether the item has had a monogram added to it|`true`, `false`|
|outfitID|string|If available|The outfit ID|`"12345"`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|quantity|number|Yes|How many of the item were added to the cart|`1`|
|upc|string|Yes|Universal purchase code ID|`"194900989333"`|