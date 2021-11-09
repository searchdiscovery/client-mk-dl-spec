# Shop Local
This custom event is to satisfy the user engagement tracking requirements as detailed in [ECB-15335](https://mk-jira.sparkred.com/browse/ECB-15335).

This custom event should fire every time a new set of products is shown to the user. This includes when a new store location is clicked, as well as when a user scrolls through the product carousel. When scrolling through the carousel, only the products shown to the user should be included in the product array.

## Code Example

```javascript
// create object with eventInfo and product object
var ddShopLocalEvent = {
  eventInfo: {
    eventName: "shopLocal",
    searchValue: "30019",
    siteSection: "store locator",
    type: "shop local",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    },
    product: [
      {
        basePrice: 45.0,
        mfr: "Michael Kors",
        mfrItemNum: "CB94C6LEX8",
        outfitID: "28415181" 
        pricePer: 25.0,
        priceType: "markdown",
        productID: "831879150",
        upc: "888318791502",
      }
    ]
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddShopLocalEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("shopLocal");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"shopLocal"`|
|searchValue|string|Yes|Value used to generate the store locator results|`"30019"`|
|siteSection|string|Yes|Store locator OR store detail|`"store locator"`, `"store detail"`|
|type|string|Yes|The event type|`"shop local"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

### Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|mfr|string|Yes|Manufacturer of the item|`michael kors`|
|mfrItemNum|string|Yes|ID used by manufacturer||
|outfitID|string|If available|The outfit ID|`"12345"`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|upc|string|Yes|Universal purchase code ID|

## Notes
The products in the smart bar should also contain query parameters leading to each product detail page. Example links:
```
https://www.michaelkors.com/blakely-leather-tote/_/R-US_30S8SZLT3L?color=1999&r8shoplocal=SITESECTION_STORECODE_SEARCHVALUE

https://www.michaelkors.com/blakely-leather-tote/_/R-US_30S8SZLT3L?color=1999&r8shoplocal=StoreLocator_3456_30019
```

`SITESECTION` should populate where the click occurred, `STORECODE` should populate the store code clicked from, and `SEARCHVALUE` should contain the value used to generate the store locator results.