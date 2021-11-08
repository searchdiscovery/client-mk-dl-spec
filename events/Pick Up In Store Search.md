# Pick Up In Store Search
Fires whenever a user searches for stores eligible for pickup.

## Code Example

```javascript
// create object with eventInfo and product object
var ddPickUpInStoreSearchEvent = {
  eventInfo: {
    eventName: "pickUpInStoreSearch",
    type: "search",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // array of product objects
    {
      basePrice: 145.0,
      customized: true,
      gwp: "N",
      gwpSku: "",
      isBaseItem: true,
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      outfitID:	"28415181",
      pricePer: 145.0,
      priceType: "list",
      productID: "831879309",
      quantity: 1,
      upc: "888318793094"
    }
  ],
  searchInfo: {
    searchQuery: "98335",
    storeID: "637",
    storeName: "MICHAEL KORS TACOMA" // name of the store
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromCartEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('pickUpInStoreSearch');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"pickUpInStoreSearch"`|
|type|string|Yes|The event type|`"search"`|
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

## Search Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|searchQuery|string|Yes|The query executed by the user|`"new york"`|
|storeID|string|Yes|The ID of the store selected by the user|`"637"`|
|storeName|string|Yes|Name of the store selected by the user|`"MICHAEL KORS TACOMA"`|