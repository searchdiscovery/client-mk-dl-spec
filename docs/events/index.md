---
title: Custom Events
---

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

**Javascript:** Since different browsers handle custom event dispatching differently, this solution uses feature detection to check for certain functionality in order to ensure cross browser compatibility. For custom event support in IE8 and IE9, a polyfill is required.

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

## Testing and Debugging
In order to debug the Launch functionality that has not yet been deployed to production, you will need to install the [Adobe Launch/DTM Switch](https://chrome.google.com/webstore/detail/adobe-dtm-switch/nlgdemkdapolikbjimjajpmonpbpmipk?hl=en) browser extension for Chrome. Set the browser extension to “debug” and “staging” in order to see the staging library and the debug information in the console.

Rules have been set up in Launch to listen for the specific custom events described in this document to fire in the DOM (on the `BODY` element):
When one of the events is dispatched, you will see the event identified in the browser’s developer console like this: 

![img]()

The first line will identify the event that fired, and the second line will represent the `mkorsData.event` array. The `mkorsData.event` array should be populated before the custom event is dispatched.

## IE8 event polyfill
Below is the polyfill, for the support of custom events on IE8 and IE9. This file is referenced in this document as `ie8eventlistener.min.js`
```js
window.Element&&window.Element.prototype.attachEvent&&!window.Element.prototype.addEventListener&&function(){function e(e,t){window.Window.prototype[e]=window.HTMLDocument.prototype[e]=window.Element.prototype[e]=t}function t(e){t.interval&&document.body&&(t.interval=clearInterval(t.interval),document.dispatchEvent(new CustomEvent("DOMContentLoaded")))}e("addEventListener",function(e,t){var n=this,o=n.addEventListener.listeners=n.addEventListener.listeners||{},r=o[e]=o[e]||[];r.length||n.attachEvent("on"+e,r.event=function(e){var t,o,a=n.document&&n.document.documentElement||n.documentElement||{scrollLeft:0,scrollTop:0},i=0,l=[].concat(r),c=!0,d=0;for(e.currentTarget=n,e.pageX=e.clientX+a.scrollLeft,e.pageY=e.clientY+a.scrollTop,e.preventDefault=function(){e.returnValue=!1},e.relatedTarget=e.fromElement||null,e.stopImmediatePropagation=function(){c=!1,e.cancelBubble=!0},e.stopPropagation=function(){e.cancelBubble=!0},e.target=e.srcElement||n,e.timeStamp=+new Date,i=0;c&&(t=l[i]);++i)for(d=0;o=r[d];++d)if(o===t){o.call(n,e);break}}),r.push(t)}),e("removeEventListener",function(e,t){var n,o,r=this,a=r.addEventListener.listeners=r.addEventListener.listeners||{},i=a[e]=a[e]||[];for(o=i.length-1;n=i[o];--o)if(n===t){i.splice(o,1);break}!i.length&&i.event&&r.detachEvent("on"+e,i.event)}),e("dispatchEvent",function(e){var t=this,n=e.type,o=t.addEventListener.listeners=t.addEventListener.listeners||{},r=o[n]=o[n]||[];try{return t.fireEvent("on"+n,e)}catch(a){return void(r.event&&r.event(e))}}),Object.defineProperty(Window.prototype,"CustomEvent",{get:function(){var e=this;return function(t,n){var o,r=e.document.createEventObject();r.type=t;for(o in n)"cancelable"===o?r.returnValue=!n.cancelable: "bubbles"===o?r.cancelBubble=!n.bubbles: "detail"===o&&(r.detail=n.detail);return r}}}),t.interval=setInterval(t,1),window.addEventListener("load",t)}(),(!this.CustomEvent||"object"==typeof this.CustomEvent)&&function(){this.CustomEvent=function(e,t){var n;t=t||{bubbles:!1,cancelable:!1,detail:void 0};try{n=document.createEvent("CustomEvent"),n.initCustomEvent(e,t.bubbles,t.cancelable,t.detail)}catch(o){n=document.createEvent("Event"),n.initEvent(e,t.bubbles,t.cancelable),n.detail=t.detail}return n}}();
```