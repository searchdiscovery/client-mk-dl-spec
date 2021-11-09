# Remove from Wishlist
Executed anywhere the user chooses to remove item(s) from the wishlist. This can happen from wishlist, or as a result of a quantity update on the wishlist page. Any other places that cause an item or items to be removed from the wishlist should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a wishlist remove and a wishlist add. 

## Code Example

```javascript
// create object with eventInfo and product object
var ddRemoveFromWishListEvent = {
  eventInfo: {
    eventName: "removeFromWishList",
    type: "wishList",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  product: [ // array of product objects
    {
      mfr: Michael Kors Mens,
      mfrItemNum: CB94C6LEX8,
      pricePer: 125.0,
      productID: 831879150,
      quantity: 1 
      upc: 888318791502,
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromWishListEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('removeFromWishList');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"removeFromWishList"`|
|type|string|Yes|The event type|`"wishlist"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|mfr|string|Yes|Manufacturer of the item|`"michael kors"`|
|mfrItemNum|string|Yes|ID used by manufacturer|`"ABC123"`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|productID|string|Yes|Product ID|`"4952115"`|
|quantity|number|No|How many of the item were added to the wishlist|`1`|
|upc|string|Yes|Universal purchase code ID|