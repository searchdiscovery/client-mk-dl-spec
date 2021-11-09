# Page Change
This event should be emitted when the view changes in a single page application (SPA).

## Code Example

```javascript
// create object with eventInfo and page object
var ddPageChangeEvent = {
  eventInfo: {
    eventName: "pageChange",
    type: "navigation",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  page: {
    name: "new page name",
    channel: "new channel",
    countryLanguage: "new countryLanguage",
    type: "new page type",
    siteSectionLevel2: "new siteSectionLevel2",
    siteSectionLevel3: "new siteSectionLevel3",
    siteType: "new site type"
  }
};

// Push it onto the event array on mkorsData object
var mkorsData = mkorsData || {};
mkorsData.event = mkorsData.event || [];
mkorsData.event.push(ddPageChangeEvent);

// Update the mkorsData object
mkorsData.page = mkorsData.page || {};
mkorsData.page = ddPageChangeEvent.page;

// Create and dispatch an event trigger
sendCustomEvent("pageChange");
```