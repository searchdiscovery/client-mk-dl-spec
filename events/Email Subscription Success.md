# Email Subscription Success
Executed when a customer submitted email is successfully subscribed. This event services the stand-alone email subscription flows such as the footer subscription or subscription from the new visitor lightbox. This event should not be sent when a user subscribes as part of an account creation activity or within the process of placing an order. 

## Code Example

```javascript
// create object with eventInfo and product object
var ddEmailSubscriptionSuccessEvent = {
  eventInfo: {
    eventName: "emailSubscriptionSuccess",
    type: "account",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddEmailSubscriptionSuccessEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("emailSubscriptionSuccess");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"emailSubscriptionSuccess"`|
|type|string|Yes|The event type|`"account"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Notes
The primary purpose of this custom event is to tell Launch that an email subscription activity succeeded. This is much more robust than just tracking a button click when the customer clicks, “Subscribe”. Launch will derive the context of the event (Lightbox, footer, et al) from other client-side information.