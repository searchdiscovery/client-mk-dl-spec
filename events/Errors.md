# Errors
Executed to support tracking of client-side exceptions. This event should be called when errors are presented as feedback to customer actions. A typical use case is when a customer has filled out a form and clicks “Continue” to submit the information or to go to the next step but the application indicates that there are some issues with the information entered. For instance, in the checkout flow, if the information entered for the shipping step fails validation, the user will be notified and directed to resolve the issue(s). 

If a single user action triggers multiple errors, each error will be represented as an object in the error array of the ddErrorEvent object.

## Code Example

```javascript
// create object with eventInfo and product object
var ddErrorEvent = {
  eventInfo: {
    eventName: "errorEvent",
    type: "customer facing error",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    },
    error: [
      {
        errorType: "emailSubscription",
        errorCode: "EM-22",
        errorMessage: "Email Address is already subscribed."
      }
    ]
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddErrorEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("errorEvent");
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
|errorType|string|Yes|The type of error thrown|`"emailSubscription"`|
|errorCode|string|Yes|The error code of the error thrown|`"EM-22"`|
|errorMessage|string|Optional|The error text presented to the user|`"Email Address is already subscribed."`|

## Notes
This is a general framework for collecting client-side exception information in Adobe Analytics via Launch. This can be used for both customer facing errors and silent application errors if there is a desire to track them. The `errorType`, `errorCode`, and `errorMessage` values are provided as an example of how the error information could be passed. If there is already a structure for this info the application, we can modify this object to fit.

The ideal scenario is that error tracking will be in English regardless of the country or language that the user has chosen. This was the thought behind `errorCode`&mdash;that it would be language neutral and that a dictionary of information keyed by `errorCode` could be uploaded to Adobe Analytics as a one time operation.