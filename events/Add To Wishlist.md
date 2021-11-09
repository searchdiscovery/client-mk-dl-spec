# Add to Wishlist
Executed anywhere the user chooses to add item(s) to the wishlist. This can happen from product detail pages, quickview pages, shopping cart, or as a result of a quantity update on the wishlist itself page. Any other places that cause an item or items to be added to the wishlist should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a wishlist remove and a wishlist add.

## Code Example

```javascript
// create object with eventInfo and product object
var ddAddToWishListEvent = {
  eventInfo: {
    eventName: "addToWishList",
    type: "wishList",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      basePrice: 145.0,
      gwp: "N",
      gwpSku: "",
      isBaseItem: true,
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      monogrammed: false,
      outfitID:  "28415181",
      pricePer: 145.0,
      priceType: "list",
      productID: "831879309",
      quantity: 2 
      upc: "888318793094",
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAddToWishListEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('addToWishList');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"addToWishList"`|
|type|string|Yes|The event type|`"wishlist"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isBaseItem|boolean|Yes|Whether or not the item is the base item|`true`, `false`|
|mfr|string|Yes|Manufacturer of the item|`"michael kors"`|
|mfrItemNum|string|Yes|ID used by manufacturer|`"ABC123"`|
|outfitID|string|If available|The outfit ID|`"12345"`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|quantity|number|No|How many of the item were added to the wishlist|`1`|
|upc|string|Yes|Universal purchase code ID|