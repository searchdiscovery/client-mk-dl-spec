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
      basePrice: 198.00,
      crossSellCartridge: "",
      gwp: false,
      gwpSku: "",
      isBaseItem: true,
      isCrossSell: false,
      lookID: "",
      mfr: "MICHAEL Michael Kors",
      mfrItemNum: "32T9UF5C2Y",
      pricePer: 198.00,
      priceType: "list",
      productID: "287781019",
      quantity: 1,
      shippingMethod: "pickup",
      storeID: "637",
      upc: "192877810193",
      storeName: "MICHAEL KORS TACOMA", // when added to pick up in store
      engraved: true,
      monogrammed: false
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
|eventName|string|Yes|The name of the event|`"shareProduct"`|
|type|string|Yes|The event type|`"product interaction"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|boolean|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|crossSellCartridge|string|?|?|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isCrossSell|boolean|Yes|Whether or not the item is cross sell eligible|`true`, `false`|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|size|string|Only if product has a size choice|Size code|`"large"`, `"12"`|
|upc|string|Yes|Universal purchase code ID|