# Custom Events
## Event Information
The event array will be a collection of events that occur during a user’s interaction with the web application. In order to standardize the triggers for user interactions with the application, we have followed the specification for events to be included in the JSO. This will allow Launch to gather data as needed without additional DOM searching or other methods. The following is an example of the events object:
```javascript
mkorsData.event: [
  {
    eventInfo: {
      eventCondition: "condition name",
      eventAction: "sample action",
      eventName: "Sample Name",
      miscProp: "Sample Other Property",
    }
  }
]
```
### Creating and Dispatching Custom Events
Launch will listen for custom browser events to occur, and fire corresponding rules to send necessary data to analytics platforms and/or marketing pixel vendors.

Below are code samples for creating and dispatching custom browser events. This solution has been tested on multiple browsers and platforms.

Browser support:
- **IE8+**
- Edge 20+
- mobile Safari 6.1+
- Android 4.4+
- Safari 7+
- Firefox 10+
- Chrome 35+

This solution does not support IE6 or IE7.

**Javascript:** Since different browsers handle custom event dispatching differently, this solution checks for certain functionality in order to ensure cross browser compatibility. For custom event support in IE8 and IE9, a polyfill is required.

The polyfill script (see appendix for source) should be included similar to this example:
```html
<!--[if lte IE 9]><script src="assets/js/ie/ie8eventlistener.min.js" ></script><![endif]-->
```

In order to eliminate code duplication and to simplify the dispatching of events, it is recommended that a function be used to handle the browser compatibility check. The event name is passed into the function as a string.
```javascript
/**
 * Creates and dispatches an event trigger
 * @param {String} evt - The name of the event
 */

function sendCustomEvent(evt){
  if (document.createEvent && document.body.dispatchEvent) {
    var event = document.createEvent('Event');
    event.initEvent(evt, true, true); // can bubble, and is cancellable
    document.body.dispatchEvent(event);
  } else if (window.CustomEvent && document.body.dispatchEvent) {
    var event = new CustomEvent(evt, {
  bubbles: true, cancelable: true });
    document.body.dispatchEvent(event);
  }
}
```
To dispatch an event, the function would just be called:
```javascript
sendCustomEvent('customEventTest');
```

### Exposing Data to Launch
The data consumed by Launch will be pulled from both the event array of the `mkorsData` object, as we