## PLP Refinements
Executed on product listing pages (including search result listings) when the user chooses to refine the result set.

## Code Example
```javascript
var ddRefinementAppliedEvent = {
  eventInfo: {
    eventName: "refinementApplied",
    type: "refinement interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false
    }
  },
  listing: {
    resultCount: 76,
    listSorting: [
      {
        sortAttribute: "price",
        sortOrder: "low-high"
      }
    ],
    refinement: [
      {
        refinementType: "color",
        refinementValue: "black"
      },
      {
        refinementType: "size",
        refinementValue: "medium"
      }
    ],
    pagination: {
      pageNum: 1,
      pageCount: 6
    }
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRefinementAppliedEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("refinementApplied");
```

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"shareProduct"`|
|type|string|Yes|The event type|`"product interaction"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|string|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## Listing Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|resultCount|number|Yes|The number of items displayed on the page|`76`|
|listSorting|array|Yes|An array of objects describing the sorting applied|
|refinement|array|Yes|An array of objects describing applied refinements|
|pagination|object|Yes|An object containing two properties: `pageNum` (the index of the current page) and `pageCount` (the total number of pages).|

### List Sorting Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|sortAttribute|string|Yes|The attribute by which the list is being sorted|`"price"`|
|sortOrder|string|Yes|The order in which the list is sorted|`"low-high"`, `"high-low"`|

### Refinement Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|refinementType|string|Yes|The type of refinement applied|`"color"`, `"size"`|
|refinementValue|string|Yes|The value for which the refinement is applied|`"black"`, `"small"`|


## Notes
1. Launch will compare the listing object of the event with the listing object on the page to determine the net change (which refinements were added, removed or changed. Please use the same ordering when creating the refinement and listSorting arrays for the base page and for the custom event.
2. After Launch determines the net change, the `mkorsData.page.listing` object will be overwritten (by Launch) to reflect the current state of the page. If this is problematic, we can discuss other strategies.