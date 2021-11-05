# Share Product
Executed anywhere the user chooses to share a product via any social media channel. This can happen from product detail pages and quickview pages on the site, but may find implementation elsewhere.

```javascript
// create object with eventInfo and product object
var ddShareProductEvent = {
  eventInfo: {
    eventName: "shareProduct",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  product: [
    {
      productID: "831879309",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094"
    }
  ],
  socialMedia: {
    channel: "facebook",
    location: "inline"
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddShareProductEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("shareProduct");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"shareProduct"`|||||||
|type|string|Yes|The event type|`"product interaction"`|||||||
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|||||||
|processed|string|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|||||||

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|mfr|string|Yes|Manufacturer of the item|`"Michael Kors"`|||||||
|mfrItemNum|string|Yes|ID used by manufacturer|`"CB99A5G0UK"`|||||||
|productID|string|Yes|The most specific ID for the product being shared|`"CB99A5G0UK"`|||||||
|upc|string|Yes|Universal purchase code ID|`"888318793094"`|||||||

## Social Media Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|channel|string|Yes|The platform to which the item was shared|`"facebook"`|
|location|string|Yes|The location of the share link or button|`"inline"`|

## Notes
During gifting seasons, the giftee may be sharing the item that they would like to receive.