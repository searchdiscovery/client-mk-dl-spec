---
title: Page Load Tracking
----

# Page Load Tracking
There is basic information that should be included in the digital data layer on all pages of the web site. This data is provided in a JSON object and is used by Adobe Launch to determine which (if any) rules should fire and what data should be sent in analytics and marketing tags.

The best practice is to create this object in server side code, convert it to JSON, and include it in an in-line script tag of the HTML markup so that the actual `window.mkorsData` object is instantiated as the page renders in the client-side browser.

Depending on the context, the object may contain multiple properties pointing to objects which describe what's presented to the user. For example, `product` is an array of one or more objects describing which products are presented to a user, added to the shopping cart, or included with a purchase. `user` is an array containing one `profile` object which contains available user data.

In addition, asynchronous [events](/events/README.md) may be pushed to the `mkorsData.events` array to describe events which take place independent of a page load.