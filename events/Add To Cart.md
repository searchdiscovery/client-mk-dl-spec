# Add to Cart
Executed when the user initially adds item(s) to the cart from product detail pages, quickview pages, or wishlist. Quantity update of a product on the shopping cart page will be handled via a separate event. Any other place that causes an item or items to be added to the cart should follow this pattern. In the case of an update to an item that changes from one sku to another, there will be both a cart remove and a cart add.

## Code Example

```javascript
// create object with eventInfo and product object
var ddAddToCartEvent = {
  eventInfo: {
    eventName: "addToCart",
    type: "cart",
    orderType: "regular",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      basePrice: 198.0,
      crossSellCartridge: "",
      engraved: true,
      gwp: false,
      gwpSku: "",
      isBaseItem: true,
      isCrossSell: false,
      lookID: "",
      mfr: "MICHAEL Michael Kors",
      mfrItemNum: "32T9UF5C2Y",
      monogrammed: false,
      pricePer: 198.0,
      priceType: "list",
      productID: "287781019",
      quantity: 1,
      upc: "192877810193",
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAddToCartEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('addToCart');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"addToCart"`|
|type|string|Yes|The event type|`"cart"`|
|orderType|string|Yes|The order type|`"regular"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|crossSellCartridge|string|?|?|
|engraved|boolean|If available|Whether or not the customer added an engraving|`true`, `false`|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isBaseItem|boolean||Whether the item is the base item|`true`, `false`|
|isCrossSell|boolean|Yes|Whether or not the item is cross sell eligible|`true`, `false`|
|lookID|string|If available|Look ID|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|monogrammed|boolean|If available|Whether the item has had a monogram added to it|`true`, `false`|
|pricePer|number|Yes|Displayed unit price of item|`445.0`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|quantity|number|No|How many of the item were added to the cart|`1`|
|upc|string|Yes|Universal purchase code ID|