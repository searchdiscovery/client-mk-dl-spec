# Order Submit Errors
This custom event is a specialization of the more general `errorEvent` for JIRA story [ECB-13570](https://mk-jira.sparkred.com/browse/ECB-13570).

In addition to the normal `error` object, this event will carry a `product` array which includes those products which must be removed from the cart due to inventory issues.

## Code Example

```javascript
// create object with eventInfo and product object
var ddErrorEvent = {
  eventInfo: {
    eventName: "errorEventOrderSubmit",
    type: "customer facing error",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    },
    error: [
      {
        errorType: "orderSubmitInventory-case_1",
        errorCode: "EM-22",
        errorMessage: "Product Out of Stock."
      }
    ],
    product: [
      {
        availability: false,
        basePrice: 45.0,
        customized: true,
        gwp: "N",
        gwpSku: "",
        isBaseItem: true,
        mfr: "Michael Kors",
        mfrItemNum: "CB94C6LEX8",
        outfitID:  "28415181",
        pickUpInStore: false,
        pickUpStoreID: "",
        pricePer: 25.0,
        priceType: "markdown",
        productID: "831879150",
        quantity: 1,
        upc: "888318791502",
      }
    ]
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddErrorEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("errorEventOrderSubmit");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"errorEvent"`|
|type|string|Yes|The event type|`"customer facing error"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|
|error|array|Yes|See **Error Properties** below|

### Error Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|errorType|string|Yes|The type of error thrown|`"orderSubmitInventory-case_1"`|
|errorCode|string|Yes|The error code of the error thrown|`"EM-22"`|
|errorMessage|string|Optional|The error text presented to the user|`"Product Out of Stock."`|

### Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|availability|boolean|Yes|Whether or not the product is available for purchase|`true`, `false`|
|basePrice|number|Yes|Base unit price of item|`445.00`|
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|mfr|string|Yes|Manufacturer of the item|`"MICHAEL KORS"`|
|mfrItemNum|string|Yes|ID used by manufacturer|`"30H6GRXE3L"`|
|pickUpStoreID|string|Only if `pickUpInStore` is `true`|The ID of the store where the customer chose to pick up the item|`"637"`|
|pickUpStoreName|string|Only if `pickUpInStore` is `true`|The name of the store where the customer chose to pick up the item|`"MICHAEL KORS TACOMA"`|
|pickUpInStore|boolean|Only on Order Confirmation screen|Whether the customer chose to pick up the item at the store instead of having it shipped|`true`, `false`|
|pricePer|number|Yes|Displayed unit price of item|`445.00`|
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|quantity|number|No|How many of the item were added to the cart|`1`|
|upc|string|Yes|Universal purchase code ID|`"194900989333"`|

## Notes
The `product` array represents all products that must be removed in order to proceed. This would include base product + baubles for a Custom Kors combination. This would include a product + GWP if that GWP is tied to a product which has gone out of stock.
