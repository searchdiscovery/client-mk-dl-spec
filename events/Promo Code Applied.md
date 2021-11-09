# Promo Code Applied
Executed when the user successfully applies a promo code.

## Code Example

```javascript
// Promo Code Example
// create object with eventInfo and product object
var ddPromoCodeEvent = {
  eventInfo: {
    eventName: "promoCodeApplied",
    promoCode: "15OFF", // text value of the successful promo code
    type: "checkout", 
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddPromoCodeEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('promoCodeSuccess');
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"promoCodeApplied"`|
|promoCode|string|Yes|The promo code applied|`"150FF"`|
|type|string|Yes|The event type|`"checkout"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|