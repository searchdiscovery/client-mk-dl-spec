![SDI logo](https://lh5.googleusercontent.com/qISy6cadFd9w5RbPc1eqZj7SISc844g8KRXSeM2P07h1PvkDJbpVtE--xNttLLSvlklK7e5dr52fGGuTGQZ19CqrLeg0dr7UuisKnKUK0xxs6IP8LfnsPMkBkfLeQfUMABH-cJn7=s0)

# Technical Specification: Data Layer - Events
Designed for sites:\
Michael Kors US/CA, Europe and future redesign

Created By:\
Stewart Schilling, Analytics Architect\
Search Discovery Inc.

| Date | Revision | Notes |
| ---- | -------- | ----- |
|11/11/2016|Version 1.1||
|4/6/2017|Version 1.2|Updated against actual usage|
|11/21/2019|Version 1.3|Updated to include dataLayerReady custom event|
|8/24/2021|Version 1.4|Merge in changes from other docs, current prod, convert to MD|

***

# Overview
This document outlines the specific changes requested of Michael Kors IT/Dev to implement events using Digital Data layer and to begin leveraging Launch for event tagging.

**NOTE:** The object examples provided in this document should be functional, but it’s highly recommended that they not be copied and pasted. The apostrophes can be unusable when copied and pasted.

An assumption has also been made that there is already a data layer implemented according to the data layer documentation. As a result, this document is only focused on the event object and utilizing custom browser events to notify Launch that an event has occurred.

## Data Layer Rendering and Timing Considerations
Where on the page should the data layer go and how should it be implemented? The general answer to this question is, “As close to the top of the document as possible, before the Adobe Launch embed, ideally within the `<head>` and as javascript within an inline `<script>` tag”. The broader answer is that the `mkorsData` object should be implemented so that it can be referenced at window scope and so that the data that it provides is there before it is needed.

Any information that might be used by Adobe Launch as a rule condition should be rendered into the HTML page prior to the Adobe Launch header embed. This is typically the information in the `mkorsData.page` object as it is very common to set up rule conditions based on page type or category. Any information that is crucial for driving A/B testing or content targeting activities that need to happen as a part of page rendering should be included above the Adobe Launch header embed.

It is perfectly OK to build the `mkorsData` object in multiple inline scripts as long as the data provided is there before it is needed by Adobe Launch. This means that you can render some of it above the Adobe Launch header embed and another part just before the Adobe Launch synchronous footer call `_satellite.pageBottom()` before the closing `body` tag. Since the majority of analytics and marketing tags are Adobe Launch page bottom rules (triggered by the `_satellite.pageBottom()` call), as long as the info in the `mkorsData` object needed by these rules (product info, cart info, page info, etc) is populated before the `pageBottom` call, everyone will be happy. 

In some cases, it may be necessary to provide some static parts of the `mkorsData` object as part of cached components or cached HTML while providing other, more dynamic data via AJAX calls or similar technologies. This is often true of user profile information, or e-commerce cart info. In these cases, it’s just fine to populate the core of the `mkorsData` object from cached inline JS and the dynamic portions from asynchronous (or synchronous) request / responses.  The guidance still applies that the data must exist in the `mkorsData` object when or before Adobe Launch expects it to be there. In the case of data provided by asynchronous methods, we may need to have Adobe Launch wait for a notification before processing data. See [Custom Events](#custom-events) below for more on this.

If it is not possible to fully create the data layer prior to the Adobe Launch embed code, it is vital that the data layer is fully created prior to dispatching the `dataLayerReady` custom event found in the [customEvent - Data Layer Complete](#customevent-data-layer-complete) section towards the end of this document.

# Page Load Tracking
## Page Load Tracking - All Pages
There is basic information that should be included in the digital data layer on all pages of the web site. This data is provided in a JSON object and is used by Adobe Launch to determine which (if any) rules should fire and what data should be sent in analytics and marketing tags. 
The best practice is to create this object in server side code, convert it to JSON, and include it in an in-line script tag of the HTML markup so that the actual `window.mkorsData` object is instantiated as the page renders in the client-side browser.

Below is an example of the core `mkorsData` object that is expected on all website pages. 
Note the absence of the tagConfig object; we no longer rely on this for Adobe Launch config. Also note the inclusion of the user object.

```javascript
// mkorsData page load info for all pages
window.mkorsData = {
  page: {
    breadcrumb: "home.html",
    channel: "Home Page",
    countryLanguage: "US:en",
    name: "Home Page",
    region: "NA",
    responsiveView: "large",
    siteSectionLevel2: "Home Page",
    siteSectionLevel3: "Home Page",
    siteType: "desktop:ecommerce",
    type: "Home Page"
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            customerType: "Customer", // "Customer", "Employee", "Associate"
            type: "registered", // "guest", "registered", "loyalist"
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet", "non-loyalty"
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            hashedID2: "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4", // sha256 hash of email address
            applePayEnabled: "true" // true or false (added for ECB-13327)
          }
        }
      ]
    }
  ]
};
```

**Notes**

1. `mkorsData.page.siteType` will have no purpose once the site is fully responsive and if the Destination Kors site goes away. Set to `responsive:ecommerce` for site redesign (PDP, PLP, SERP, Home).
2. `mkorsData.page.responsiveView` is provided for site redesign to carry the responsive view of the page at the time it is loaded. The value might be XSmall, Small, Medium, or Large depending on how many responsive breakpoints there are.
3. See notes on the `hashedID` that are included in this document on the Sign In Success custom event. (md5 hash of trimmed, lowercased, email address)
4. [ECB-13327](https://mk-jira.sparkred.com/browse/ECB-13327) Added `mkorsData.user[n].profile[n].profileInfo.applePayEnabled: /true|false/`

## Page Load - Product Detail Pages
Product Detail Pages will have the following data layer JSON object:

```javascript
// mkorsData page load info for PDP pages
window.mkorsData = {
  page: {
    breadcrumb: "/sloan-tango-small-quilted-leather-shoulder-bag/_/R-US_12AB34CD56EF",
    channel: "HANDBAGS",
    countryLanguage: "US:en",
    name: "Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag",
    region: "NA",
    responsiveView: "large",
    siteSectionLevel2: "Home > HANDBAGS",
    siteSectionLevel3: "Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag",
    siteType: "desktop:ecommerce",
    type: "Product Detail" // see notes below
  },
  product: {
    SkuVariants: [
      {
        availability: "Y",
        basePrice: "445.00",
        color: "BROWN/BLACK",
        pricePer: "598.00",
        priceType: "Markdown",
        productID: "4952115",
        size: "ONE SIZE"
      },
      {
        availability: "Y",
        basePrice: "445.00",
        color: "BLUE",
        pricePer: "598.00",
        priceType: "Markdown",
        productID: "4952116",
        size: "ONE SIZE"
      }
    ],
    availability: "Y",
    basePrice: "598.0",
    categoryID: "cat20099",
    categoryName: "NEW ARRIVALS",
    color: "BROWN/BLACK",
    crossSellCartridge: "",
    gwp: "N",
    gwpSku: "",
    isCrossSell: "",
    keywords: "",
    mfr: "Michael Kors Studio",
    mfrItemNum: "30H6SOAL2L",
    name: "SloanTangoSmallQuilted-LeatherShoulderBag",
    pricePer: "598.0",
    priceType: "List",
    productID: "4952115",
    qtyAvailable: 34,
    upc: "190049521151",
    isEngravable: "true", // "true" or "false" depending if a product can be engraved
    isMonogrammable: "true" // "true" or "false" depending if a product can be engraved
  },
  crossSellGroup: [
    {
      strategy: "We Think You Will Love",
      productCount: 2,
      product: [
        {
          displayIndex: 0,
          mfr: "Michael Kors Studio",
          mfrItemNum: "30H6SOAL2L",
          productID: "13452115"
        },
        {
          displayIndex: 1,
          mfr: "Michael Kors",
          mfrItemNum: "10X6SOAL34",
          productID: "134521755"
        }
      ]
    },
    {
      strategy: "Recently Viewed",
      productCount: 2,
      product: [
        {
          displayIndex: 0,
          mfr: "Michael Kors Studio",
          mfrItemNum: "30H6SABC456",
          productID: "13452122"
        },
        {
          displayIndex: 1,
          mfr: "MKGO Lounge",
          mfrItemNum: "30H6OUBC123",
          productID: "134576890"
        }
      ]
    }
  ],
  user: [
    { /* object for carrying user info */ }
  ]
}
```
**Notes**

1. The following objects have been removed (they are not in use today and have no planned use): 
  - `mkorsData.product.availability`
  - `mkorsData.product.qtyAvailable`
  - `mkorsData.product.description`
2. The product object has been changed to an array of product objects so that we can support multiple products on a page in the future (perhaps Stylist driven outfits (i.e. The Look) which might be two or more primary products on a page).
3. This same data layer info will be expected upon the opening of a QuickView (See [QuickView](#customevents-quickview) in the custom events section of this document).
4. The `crossSellGroup` array is added for the 2017 redesign as there may be multiple cross sell strategies use on PDP (or elsewhere).  Each cross sell strategy has a `crossSellGroup` object which includes info about the strategy, the number of products returned and an array of product objects each with a display index.
5. `product[n].priceType` is requested for any primary products on page. Note that we presently scrape the DOM in Launch to determine price type.
6. The `mkorsData.page.type` value should reflect product configurator values as well, such as “Product Detail Monogramming” and “Product Detail Engraving”.

## Page Load - Product Listing Pages
Product Listing Pages include product listings as a result of category navigation as well as search results. When product listing pages are first loaded, a page data layer is created as shown below.  In most cases, we will have a result count, a default sort order and pagination information, but we will not have refinements already applied. However, it is assumed that we could have a page loaded with refinements applied as the result of a shared or bookmarked link or a page refresh. As such, the refinements array is included below.
```javascript
// mkorsData page load info for PLP pages
window.mkorsData = {
  page: {
    atgCategoryID: "cat20126",
    channel: "SHOES",
    countryLanguage: "US:en",
    merchCategoryLevel1: "SHOES",
    merchCategoryLevel2: "Home > SHOES > ANKLE BOOTS",
    merchCategoryLevel3: "Home > SHOES > ANKLE BOOTS",
    name: "Home > SHOES > ANKLE BOOTS",
    responsiveView: "large",
    siteSectionLevel2: "Home > SHOES",
    siteSectionLevel3: "Home > SHOES > ANKLE BOOTS",
    siteType: "desktop:ecommerce",
    type: "SubCategory"
  },
  listing: {
    resultCount: 60,
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
        refinementType: "color",
        refinementValue: "navy"
      },
      {
        refinementType: "size",
        refinementValue: "medium"
      }
    ],
    pagination: {
      pageNum: 1,
      pageCount: 5
    },
    query: "", // set to the search keyword if listing is a search result
    queryReplaced: "" // set to the replaced search keyword if listing is a search result
  },
  user: [{
  /*future object for carrying user info. Later in 2017.*/ }]
}
```
**Notes**

It is desirable to have sorting and refinement information provided in English regardless of the end user’s language selection. Subsequent refinements or sort order selections after page load will be tracked via custom events (see customEvent - PLP Refinements).

## Page Load - Shopping Cart Page
The Shopping Cart Page will have the following data layer JSON object.
```javascript
// mkorsData page load info for Shopping Cart page
window.mkorsData = {
  page: {
    channel: "Shopping Cart",
    countryLanguage: "US:en",
    name: "Shopping Cart",
    siteSectionLevel2: "Shopping Cart",
    siteSectionLevel3: "Shopping Cart",
    siteType: "desktop:ecommerce",
    responsiveView: "large",
    type: "Shopping Cart"
  },
  cart: {
    orderType: "regular", // "regular" or "preorder" depending on order type
    product: [
      {
        productID: "831879309",
        pricePer: 145.0,
        basePrice: 145.0,
        priceType: "List",
        mfr: "Michael Kors",
        mfrItemNum: "CB99A5G0UK",
        upc: "888318793094",
        outfitID: "28415181",
        customized: "false",
        isBaseItem: "",
        gwp: "N",
        gwpSku: "",
        quantity: 2,
        pickUpInStore: "N",
        pickUpStoreID: "",
        pickUpStoreName: "",
        available: "Y",
        monogrammed: "true",
        engraved: "false" // "true" or "false" if a product is engraved
      },
      {
        productID: "831879150",
        pricePer: 25.0,
        basePrice: 45.0,
        priceType: "Markdown",
        mfr: "Michael Kors",
        mfrItemNum: "CB94C6LEX8",
        upc: "888318791502",
        outfitID: "28415181",
        customized: "true",
        isBaseItem: "true",
        gwp: "N",
        gwpSku: "",
        quantity: 1,
        pickUpInStore: "Y",
        pickUpStoreID: "abcd1234",
        pickUpStoreName: "MICHAEL KORS TACOMA",
        available: "Y",
        monogrammed: "true",
        engraved: "false" // "true" or "false" if a product is engraved
      }
    ]
  },
  crossSellGroup: [
    {
      strategy: "You may also like",
      productCount: 4,
      product: [
        {
          productID: "13452115",
          mfr: "Michael Kors Studio",
          mfrItemNum: "30H6SOAL2L",
          displayIndex: 1
        },
        {
          productID: "134521755",
          mfr: "Michael Kors",
          mfrItemNum: "10X6SOAL34",
          displayIndex: 2
        }
      ]
    },
    {
      strategy: "Recently Viewed",
      productCount: 3,
      product: [
        {
          productID: "13452122",
          mfr: "Michael Kors Studio",
          mfrItemNum: "30H6SABC456",
          displayIndex: 1
        }
      ]
    }
  ]
}
```
**Notes:** 

1. Present Launch page load is scraping the DOM to align price info with products in the data layer. It’s super fragile and WILL break.
2. The addition of Kors Custom items (with `baseItems` and outfit groupings) has made the DOM scraping more difficult and trouble prone.
3. The addition of “The Look” has added to the complexity.
4. `priceType` by product has been on the list for inclusion for quite some time.
5. I anticipate that shipping method (ship to store vs ship to address) will also be an ask from the analytics team.
6. Present Launch code does not track crossSells shown at the bottom of the cart. An object is added here, matching the structure of crossSells on PDP.


I would suggest that we have a discussion around what data exists in the application state about shopping carts and the products within? If we had this understanding, we could better advise the mapping to the data layer.

## Page Load - Checkout Pages
The checkout pages will have the following data layer JSON object.
```javascript
// mkorsData page load info for Shopping Cart page
window.mkorsData = {
  page: {
    breadcrumb: "/checkout/checkout.jsp",
    channel: "checkout",
    countryLanguage: "US:en",
    name: "APPROPRIATE_NAME", // e.g. checkout:shipping OR checkout:billing
    responsiveView: "large",
    siteSectionLevel2: "APPROPRIATE_NAME", // checkout:shipping OR checkout:billing
    siteSectionLevel3: "APPROPRIATE_NAME", // checkout:shipping OR checkout:billing
    siteType: "desktop:ecommerce",
    type: "APPROPRIATE_NAME" // checkout:shipping OR checkout:billing
  },
  cart: {
    currency: "USD",
    customerID: "49115482",
    customerType: "0",
    product: [
      {
        availability: "Y",
        basePrice: "378.0",
        category: "Shoulder Bags",
        categoryID: "cat20103",
        color: "SUNFLOWER",
        gwp: "N",
        gwpSku: "",
        isCrossSell: "N",
        mfr: "MICHAEL Michael Kors",
        mfrItemNum: "30T9G0El8L",
        name: "CeceMediumQuiltedLeatherConvertibleShoulderBag",
        orderType: "regular",
        pickUpInStore: "N",
        pickUpStoreID: "",
        pickUpStoreName: "",
        pricePer: "283.5",
        priceType: "Markdown",
        productID: "359929205",
        qty: "1",
        size: "ONE SIZE",
        sku: "359929205",
        upc: "000000193599292052"
      },
      {
        availability: "Y",
        basePrice: "228.0",
        category: "The Monogram Shop",
        categoryID: "cat3140001",
        color: "SOFT PINK",
        gwp: "N",
        gwpSku: "",
        isBaseItem: "true",
        isCrossSell: "N",
        mfr: "MICHAEL Michael Kors",
        mfrItemNum: "30T9GV0T3L",
        name: "EvaLargePeppledLeatherToteBag",
        orderType: "regular",
        pickUpInStore: "N",
        pickUpStoreID: "",
        pickUpStoreName: "",
        pricePer: "171.0",
        priceType: "Markdown",
        productID: "287779518",
        qty: "1",
        size: "ONE SIZE",
        sku: "287779518",
        upc: "000000192877795186"
      }
    ]
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            applePayEnabled: "true",
            emailOptIn: "true",
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            hashedID2: "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4", // sha256 hash of email
            loginStatus: "logged in", // "logged in", "logged out"
            loyaltyOptIn: "logged in", // "logged in", "logged out"
            loyaltyTier: "studio", // "backstage", "runway", "red carpet", "non-loyalty"
            type: "registered", // "guest", "registered", "loyalist"
            zipCode: "30052-9277"
          }
        }
      ]
    }
  ]
};
```
**Notes:** 
## Page Load - Order Confirmation Page
The Order Confirmation Page will have the following data layer JSON object.
```javascript
// mkorsData page load info for Order Confirmation page
window.mkorsData = {
  page: {
    name: "checkout:confirmation",
    channel: "checkout",
    countryLanguage: "US:en",
    type: "checkout:confirmation",
    siteSectionLevel2: "checkout:confirmation",
    siteSectionLevel3: "checkout:confirmation",
    siteType: "desktop:ecommerce",
    responsiveView: "medium"
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            type: "registered",
            loginStatus: "logged in",
            loyaltyTier: "NA",
            hashedID: "7a8e1e3e9a2116bd77e4f92ed60b1ae7",
            applePayEnabled: "true" // true or false (added for ECB-13327)
          }
        }
      ]
    }
  ],
  transaction: {
    orderID: "w8244902",
    orderType: "regular", // "regular" or "preorder" depending on order type
    paymentMethod: "visa",
    shippngMethod: "Ground Shipping",
    billingState: "WI",
    billingZipCode: "53533-8825",
    shippingState: "WI",
    shippingZipCode: "53533-8825",
    billingCountry: "US",
    shippingCountry: "US",
    customerID: "13466870",
    customerType: "0",
    currency: "USD",
    salesTax: "24.53",
    shippingCity: "DODGEVILLE",
    shippingCost: "0.0",
    shippingType: "GROUND",
    orderDiscountAmount: "0.00",
    nonProductGwp: "",
    product: [
      {
        color: "ELECTRIC BLUE",
        category: "NEW ARRIVALS",
        categoryID: "cat3240085",
        mfr: "Michael Kors Studio",
        mfrItemNum: "30F6SM9T3L",
        name: "MercerLargeLeatherTote",
        pricePer: "298.0",
        priceType: "List",
        productID: "86448190",
        qty: "1",
        customized: "true",
        outfitID: "35185404",
        isBaseitem: "true",
        isCrossSell: "N",
        productDiscountAmount: "0.0",
        giftwrapAmount: "0.0",
        markdownAmount: "0.0",
        size: "ONE SIZE",
        sku: "86448190",
        upc: "000000190864481906",
        gwpSku: "",
        gwp: "N",
        pickUpInStore: "Y",
        pickUpStoreID: "637",
        pickUpStoreName: "MICHAEL KORS TACOMA",
        monogrammed: "true",
        engraved: "false" // "true" or "false" if a product is engraved
      },
      {
        color: "DK SANGRIA",
        category: "Under $100",
        categoryID: "cat3260121",
        mfr: "MICHAEL Michael Kors",
        mfrItemNum: "34T7TNYN1C",
        name: "FloralSilkScarf",
        pricePer: "38.0",
        priceType: "List",
        productID: "126219812",
        qty: "1",
        customized: "true",
        outfitID: "35185404",
        isBaseitem: "",
        isCrossSell: "Y",
        productDiscountAmount: "0.0",
        giftwrapAmount: "0.0",
        markdownAmount: "0.0",
        size: "ONE SIZE",
        sku: "126219812",
        upc: "000000191262198120",
        gwpSku: "",
        gwp: "N",
        pickUpInStore: "Y",
        pickUpStoreID: "637",
        pickUpStoreName: "MICHAEL KORS TACOMA",
        monogrammed: "true",
        engraved: "false" // "true" or "false" if a product is engraved
      },
      {
        color: "OPTIC WHITE",
        category: "SHOES",
        categoryID: "cat20014",
        mfr: "MICHAEL Michael Kors",
        mfrItemNum: "40T7SYFA2L",
        name: "SonyaEmbellishedLeatherSandal",
        pricePer: "110.0",
        priceType: "List",
        productID: "89613259",
        qty: "1",
        customized: "true",
        outfitID: "35185404",
        isBaseitem: "",
        isCrossSell: "Y",
        productDiscountAmount: "0.0",
        giftwrapAmount: "0.0",
        markdownAmount: "0.0",
        size: "8",
        sku: "89613259",
        upc: "000000190896132593",
        gwpSku: "",
        gwp: "N",
        pickUpInStore: "Y",
        pickUpStoreID: "637",
        pickUpStoreName: "MICHAEL KORS TACOMA",
        monogrammed: "true",
        engraved: "false" // "true" or "false" if a product is engraved
      }
    ]
  }
};
```
**Notes:** 
1. At present Launch is scraping the DOM determine and set the `product[n].monogrammed` flag. It’s super fragile and WILL break.
2. `mkorsData.transaction.product[2].pickupstoreid` is shown above to demonstrate how the pick up in store (Click & Collect) information may be passed.
3. In the spec above, `transaction.product` is an array of product objects. This aligns with the rest of the data layer where we use an array of products (e.g. `addToBag` for custom items). The present (as of 9/2017) implementation of products within the transaction object is an “associative array” instead of an array object. In Launch we are looping through the associative array using
    ```javascript
    for (var i in mkorsData.transaction.product) {...}
    ```
    This looping control structure will work with both the current and future product structures.
    
    To be clear, the current implementation is like this:
    ```javascript
    transaction: {
      product: {
        "0": {...},
        "1": {...},
        "2": {...}
      }
    }
    ```
    But at some point, we would like it to be like this:
    ```javascript
    transaction: {
      product: [
        {...},
        {...},
        {...}
      ]
    }
    ```

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


## customEvent - Quick View
Executed when a quick view dialog is displayed. Since a new page is not loaded when this happens, we need to put the product information into the data layer and dispatch an event to let Launch know about it.

```javascript
// Quick View Example
// create object with eventInfo and product object
var ddQuickViewEvent = {
  eventInfo: {
    eventName: "quickView",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // array of product objects
    {
      categoryID: "cat20099",
      categoryName: "NEW ARRIVALS",
      gwp: "N",
      gwpSku: "",
      mfr: "Michael Kors Studio",
      mfrItemNum: "30H6SOAL2L",
      pricePer: 598.0,
      basePrice: 445.0,
      priceType: "Markdown",
      productID: "4952115",
      upc: "190049521151",
      customized: false
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddQuickViewEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('quickView');
```
## customEvent - Color Selection on PDP, QV, (and PLP in redesign)
Executed anywhere the user chooses to select the color of a product. This can happen from product detail pages and quickview pages on the site today (non-responsive site). As the 2017 site redesign is rolled out making Home Page, PDP, and PLP responsive, it is understood that color selection will also be available on the PLP (and SERP).
```javascript
// Product Color Selection Example
// create object with eventInfo and product object
var ddColorSelectionEvent = {
  eventInfo: {
    eventName: "colorSelection",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // use an array even though this will most likely always be a single item
    {
      productID: "831879309",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094",
      colorCode: "BLACK"
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddColorSelectionEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("colorSelection");
```

## customEvent - Size Selection on PDP, QV
Executed anywhere the user chooses to select the size of a product. This can happen from product detail pages and quickview pages on the site.

```javascript
// Product Size Selection Example
// create object with eventInfo and product object
var ddSizeSelectionEvent = {
  eventInfo: {
    eventName: "sizeSelection",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // use an array even though this will most likely always be a single item
    {
      productID: "831879309",
      pricePer: "145.0",
      basePrice: "145.0",
      priceType: "List",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094",
      sizeCode: "LARGE",
      colorCode: "BLACK",
      availability: "y"
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddSizeSelectionEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("sizeSelection");
```
## customEvent - Share Product
Executed anywhere the user chooses to share a product via any social media channel. This can happen from product detail pages and quickview pages on the site, but may find implementation elsewhere.
```javascript
// Product Share Example
// create object with eventInfo and product object
var ddShareProductEvent = {
  eventInfo: {
    eventName: "shareProduct",
    type: "product interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // use an array even though this will most likely always be a single item
    {
      productID: "831879309",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094"
    }
  ],
  socialMedia: {
    channel: "facebook"
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddShareProductEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("shareProduct");
```

**Notes:** 
The omniClick function `dtmShareProduct` had both `productID` and `skuID` being sent in. The function only uses the `skuID`, so the `productID` being shared here should be the most specific ID for the product being shared. In other words, if the use had selected size and color on a PDP prior to sharing, we’d want to use that sku. During gifting seasons, the giftee may be sharing the item that they would like to receive. 

## customEvent - PLP Refinements
Executed on product listing pages (including search result listings) when the user chooses to refine the result set.

```javascript
// PLP Refinement Example
var ddRefinementAppliedEvent = {
  eventInfo: {
    eventName: "refinementApplied",
    type: "refinement interaction",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
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
**Notes:**
1. Launch will compare the listing object of the event with the listing object on the page to determine the net change (which refinements were added, removed or changed. Please use the same ordering when creating the refinement and listSorting arrays for the base page and for the custom event.
2. After Launch determines the net change, the `mkorsData.page.listing` object will be overwritten (by Launch) to reflect the current state of the page. If this is problematic, we can discuss other strategies.

## customEvent - Add to Cart
Executed when the user initially adds item(s) to the cart from product detail pages, quickview pages, or wishlist. Quantity update of a product on the shopping cart page will be handled via a separate event. Any other place that causes an item or items to be added to the cart should follow this pattern. In the case of an update to an item that changes from one sku to another, there will be both a cart remove and a cart add.

```javascript
// Add to Cart Example
// create object with eventInfo and product object
var ddAddToCartEvent = {
  eventInfo: {
    eventName: "addToCart",
    type: "cart",
    orderType: "regular", // "regular" or "preorder" depending on order type
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // array of product objects
    {
      basePrice: "198.00",
      crossSellCartridge: "",
      gwp: "N",
      gwpSku: "",
      isBaseItem: true,
      isCrossSell: "N",
      lookID: "",
      mfr: "MICHAEL Michael Kors",
      mfrItemNum: "32T9UF5C2Y",
      pricePer: "198.00",
      priceType: "List",
      productID: "287781019",
      quantity: 1,
      shippingMethod: "pickup",
      storeID: "637",
      upc: "192877810193",
      storeName: "MICHAEL KORS TACOMA", // when added to pick up in store
      engraved: "true", // "true" or "false" if the product is engraved
      monogrammed: "false" // "true" or "false" if the product is monogrammed 
    },
    {
      basePrice: "45.0",
      crossSellCartridge: "",
      gwp: "N",
      gwpSku: "",
      isBaseItem: false,
      isCrossSell: "N",
      lookID: ""
      mfr: "Michael Kors",
      mfrItemNum: "CB94C6LEX8",
      pricePer: "25.0",
      priceType: "Markdown",
      productID: "831879150",
      quantity: 1,
      shippingMethod: "pickup",
      storeID: "637",
      upc: "192877810193",
      storeName: "MICHAEL KORS TACOMA", // when added to pick up in store
      engraved: "true", // "true" or "false" if the product is engraved
      monogrammed: "false" // "true" or "false" if the product is monogrammed 
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAddToCartEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('addToCart');
```

## customEvent - Remove from Cart
Executed only when the user initially completely removes item(s) from the cart. This can happen from the cart by clicking remove or as a result of a quantity update on the shopping cart page. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a cart remove and a cart add.

```javascript
// Remove from Cart Example
// create object with eventInfo and product object
var ddRemoveFromCartEvent = {
  eventInfo: {
    eventName: "removeFromCart",
    type: "cart",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed
    }
  },
  product: [ // array of product objects
    {
      productID: "831879309",
      pricePer: 145.0,
      basePrice: 145.0,
      priceType: "List",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094",
      isBaseItem: "true",
      outfitID:  "28415181",
      customized: "true",
      gwp: "N",
      gwpSku: "",
      quantity: 2
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromCartEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('removeFromCart');
```

## customEvent - Add to Wishlist
Executed anywhere the user chooses to add item(s) to the wishlist. This can happen from product detail pages, quickview pages, shopping cart, or as a result of a quantity update on the wishlist itself page. Any other places that cause an item or items to be added to the wishlist should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a wishlist remove and a wishlist add.

```javascript
// Add to Wishlist Example
// create object with eventInfo and product object
var ddAddToWishListEvent = {
  eventInfo: {
    eventName: "addToWishList",
    type: "wishList",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  product: [ // array of product objects
    {
      productID: "831879309",
      pricePer: 145.0,
      basePrice: 145.0,
      priceType: "List",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094",
      isBaseItem: true,
      outfitID:  "28415181",
      monogrammed: false,
      gwp: "N",
      gwpSku: "",
      quantity: 2 
    },
    {
      productID: "831879150",
      pricePer: 25.0,
      basePrice: 45.0,
      priceType: "Markdown",
      mfr: "Michael Kors",
      mfrItemNum: "CB94C6LEX8",
      upc: "888318791502",
      isBaseItem: true,
      outfitID:  "28415181",
      monogrammed: false,
      gwp: "N",
      gwpSku: "",
      quantity: 1
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAddToWishListEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('addToWishList');
```

## customEvent - Remove from Wishlist
Executed anywhere the user chooses to remove item(s) from the wishlist. This can happen from wishlist, or as a result of a quantity update on the wishlist page. Any other places that cause an item or items to be removed from the wishlist should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a wishlist remove and a wishlist add. 

```javascript
// create object with eventInfo and product object
var ddRemoveFromWishListEvent = {
  eventInfo: {
    eventName: "removeFromWishList",
    type: "wishList",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  product: [ // array of product objects
    {
      productID: 831879150,
      pricePer: 125.0,
      mfr: Michael Kors Mens,
      mfrItemNum: CB94C6LEX8,
      upc: 888318791502,
      quantity: 1 
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromWishListEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('removeFromWishList');
```

## customEvent - Add to Favorites (EU Only)
Executed anywhere the user chooses to add item(s) to the favorites. This can happen from product detail pages, quickview pages, shopping cart, or as a result of a quantity update on the favorites itself page. Any other places that cause an item or items to be added to the favorites should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a favorites remove and a favorites add.

4/21/17 - Add to Favorites functionality should be replaced at some point by Add to Wishlist. Favorites is still on EU sites, but we expect a move to Wish list globally. Assuming this is true, we wouldn’t want to spend time on this.

```javascript
// Add to Favorites Example
// create object with eventInfo and product object
var ddAddToFavoritestEvent = {
  eventInfo: {
    eventName: "addToFavorites",
    type: "favorites",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  product: [ // array of product objects
    {
      productID: "831879309",
      pricePer: 145.0,
      basePrice: 145.0,
      priceType: "List",
      mfr: "Michael Kors",
      mfrItemNum: "CB99A5G0UK",
      upc: "888318793094",
      isBaseItem: true,
      outfitID:  "28415181",
      monogrammed: false,
      gwp: "N",
      gwpSku: "",
      quantity: 2 
    },
    {
      productID: "831879150",
      pricePer: 25.0,
      basePrice: 45.0,
      priceType: "Markdown",
      mfr: "Michael Kors",
      mfrItemNum: "CB94C6LEX8",
      upc: "888318791502",
      isBaseItem: true,
      outfitID:  "28415181",
      monogrammed: false,
      gwp: "N",
      gwpSku: "",
      quantity: 1
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAddToFavoritesEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('addToFavorites');
```

## customEvent - Remove from Favorites (EU Only)
Executed anywhere the user chooses to remove item(s) from the favorites. This can happen from wishlist, or as a result of a quantity update on the wishlist page. Any other places that cause an item or items to be removed from the favorites should follow this pattern. In the case of an update to an item that changes from one Fabric/Color to another, there will be both a wishlist remove and a favorites add.

```javascript
// create object with eventInfo and product object
var ddRemoveFromFavoritesEvent = {
  eventInfo: {
    eventName: "removeFromFavorites",
    type: "favorites",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  product: [ // array of product objects
    {
      productID: "831879150",
      pricePer: 125.0,
      mfr: "Michael Kors Mens",
      mfrItemNum: "CB94C6LEX8",
      upc: "888318791502",
      quantity: 1
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddRemoveFromFavoritesEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent('removeFromFavorites');
```

## customEvent - Sign In Success
Executed when a customer successfully signs in to an existing account. 

```javascript
// create object with eventInfo and product object
var ddSignInSuccessEvent = {
  eventInfo: {
    eventName: "signInSuccess",
    type: "account",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            customerType: "Customer", // "Customer", "Employee", "Associate"
            type: "registered", // "guest", "registered", "loyalist"
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet", "non-loyalty"
            hashedID: "7ddb5eae16468674b843f396b335a7dd" // md5 hash of email address   
          }
        }
      ]
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddSignInSuccessEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("signInSuccess");
```

**Notes:**
The hashedID in the `user[n].profile[n]` object is a one-way hash of the customer’s email address. This value is fed into the analytics data stream (and also into a few marketing pixels) for the purpose of visitor stitching across devices and back-end matching of online data to CRM data.

The algorithm used for hashing is up to Michael Kors and the same algorithm must be used in all back-end systems in order for matching to work. Whatever the hashing (or encryption) process, be sure to standardize the plain-text email address format before processing; This means forcing the string to lowercase and encode special characters (if any).  Also, be certain to document the full process and follow it to the letter on all systems that will convert customer ID’s (email or otherwise) into hashed or encrypted keys.

## customEvent - Account Creation Success
Executed when a customer successfully creates an account.

```javascript
// create object with eventInfo and product object
var ddAccountCreationSuccessEvent = {
  eventInfo: {
    eventName: "accountCreationSuccess",
    type: "account",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            customerType: "Customer", // "Customer", "Employee", "Associate"
            type: "registered", // "guest", "registered", "loyalist"
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet", "non-loyalty"
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            emailOptIn: true, // Indicates whether this account is opted in for emails
            loyaltyOptIn: true // Indicates whether this account is opted in for VIP  
          } 
        }
      ]
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddAccountCreationSuccessEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("accountCreationSuccess");
```

**Notes:**
hashedID in the user[n].profile[n] object is a one-way hash of the customer’s email address. See notes on customEvent - Sign In Success for more details on this field.emailOptIn is set to indicate whether the newly registered customer chose to opt in to email newsletters or not.

## customEvent - Loyalty Sign Up Success
Executed when an existing registered customer successfully joins the loyalty program. 

```javascript
// create object with eventInfo and product object
var ddLoyaltySignupSuccessEvent = {
  eventInfo: {
    eventName: "loyaltySignupSuccess",
    type: "account",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            customerType: "Customer", // "Customer", "Employee", "Associate"
            type: "registered", // "guest", "registered", "loyalist"
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet"
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            emailOptIn: true // Indicates whether this account is opted in for emails
          } 
        }
      ]
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddLoyaltySignupSuccessEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("loyaltySignupSuccess");
```

## customEvent - Loyalty Opt Out Success
Executed when an existing registered loyalist successfully leaves the loyalty program.

```javascript
// create object with eventInfo and product object
var ddLoyaltyOptOutpSuccessEvent = {
  eventInfo: {
    eventName: "loyaltyOptOutSuccess",
    type: "account",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    }
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            customerType: "Customer", // "Customer", "Employee", "Associate"
            type: "registered", // "guest", "registered", "loyalist"
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet"
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            emailOptIn: true // Indicates whether this account is opted in for emails
          } 
        }
      ]
    }
  ]
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddLoyaltyOptOutpSuccessEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("loyaltyOptOutSuccess");
```

## customEvent - Email Subscription Success
Executed when a customer submitted email is successfully subscribed. This event services the stand-alone email subscription flows such as the footer subscription or subscription from the new visitor lightbox. This event should not be sent when a user subscribes as part of an account creation activity or within the process of placing an order. 

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

**Notes:**
The primary purpose of this custom event is to tell Launch that an email subscription activity succeeded. This is much more robust than just tracking a button click when the customer clicks, “Subscribe”. Launch will derive the context of the event (Lightbox, footer, et al) from other client-side information.

## customEvent - Errors
Executed to support tracking of client-side exceptions. This event should be called when errors are presented as feedback to customer actions. A typical use case is when a customer has filled out a form and clicks “Continue” to submit the information or to go to the next step but the application indicates that there are some issues with the information entered. For instance, in the checkout flow, if the information entered for the shipping step fails validation, the user will be notified and directed to resolve the issue(s). 

If a single user action triggers multiple errors, each error will be represented as an object in the error array of the ddErrorEvent object.

```javascript
// create object with eventInfo and product object
var ddErrorEvent = {
  eventInfo: {
    eventName: "errorEvent",
    type: "customer facing error",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    },
    error: [
      {
        errorType: "emailSubscription",
        errorCode: "EM-22", // If possible. Allows for language neutral reporting
        errorMessage: "Email Address is already subscribed." // Not needed if errorCode exists
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

**Notes:** 
This is a general framework for collecting client-side exception information in Adobe Analytics via Launch. This can be used for both customer facing errors and silent application errors if there is a desire to track them. The errorType, errorCode, and errorMessage values are provided as an example of how the error information could be passed. If there is already a structure for this info the application, we can modify this object to fit.

The ideal scenario is that error tracking will be in English regardless of the country or language that the user has chosen. This was the thought behind errorCode—that it would be language neutral and that a dictionary of information keyed by errorCode could be uploaded to Adobe Analytics as a one time operation.

## customEvent - Order Submit Errors
This custom event is a specialization of the more general `errorEvent` for JIRA story [ECB-13570](https://mk-jira.sparkred.com/browse/ECB-13570).

In addition to the normal `error` object, this event will carry a `product` array which includes those products which must be removed from the cart due to inventory issues.

```javascript
// create object with eventInfo and product object
var ddErrorEvent = {
  eventInfo: {
    eventName: "errorEventOrderSubmit",
    type: "customer facing error",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    },
    error: [
      {
        errorType: "orderSubmitInventory-case_1", // case 1-4 from https://mk-jira.sparkred.com/browse/ECB-13570
        errorCode: "EM-22", // If possible. Allows for language neutral reporting
        errorMessage: "Product Out of Stock." // Not needed if errorCode exists
      }
    ],
    product: [ // array of product objects that must be removed to place order
      {
        productID: "831879150",
        pricePer: 25.0,
        basePrice: 45.0,
        priceType: "Markdown",
        mfr: "Michael Kors",
        mfrItemNum: "CB94C6LEX8",
        upc: "888318791502",
        outfitID:  "28415181",
        customized: "true",
        isBaseItem: "true", // set for Kors Custom items (along with customized and outfitID)
        gwp: "N",
        gwpSku: "",
        quantity: 1,
        pickUpInStore: "N",
        pickUpStoreID: "",
        available: "N" 
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

**Notes:** 
The product array represents all products that must be removed in order to proceed. This would include base product + baubles for a Custom Kors combination. This would include a product + GWP if that GWP is tied to a product which has gone out of stock.

## customEvent - Shop Local
This custom event is to satisfy the user engagement tracking requirements as detailed in [ECB-15335](https://mk-jira.sparkred.com/browse/ECB-15335).

This custom event should fire every time a new set of products is shown to the user. This includes when a new store location is clicked, as well as when a user scrolls through the product carousel. When scrolling through the carousel, only the products shown to the user should be included in the product array.

```javascript
// create object with eventInfo and product object
var ddShopLocalEvent = {
  eventInfo: {
    eventName: "shopLocal",
    searchValue: "30019", // value used to generate the store locator results
    siteSection: "store locator", // store locator OR store detail
    type: "shop local",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
    },
    product: [ // array of products presented to the user
      {
        productID: "831879150",
        pricePer: "25.0",
        basePrice: "45.0",
        priceType: "Markdown", // List or Markdown
        mfr: "Michael Kors",
        mfrItemNum: "CB94C6LEX8",
        upc: "888318791502",
        outfitID: "28415181" 
      }
    ]
  }
};

// Push it onto the event array on mkorsData object
window.mkorsData = window.mkorsData || {};
window.mkorsData.event = window.mkorsData.event || [];
window.mkorsData.event.push(ddShopLocalEvent);

// Create and dispatch an event trigger (using predefined sendCustomEvent function)
sendCustomEvent("shopLocal");
```

**Notes:** 
The products in the smart bar should also contain query parameters leading to each product detail page. Example link:
- https://www.michaelkors.com/blakely-leather-tote/_/R-US_30S8SZLT3L?color=1999&r8shoplocal=SITESECTION_STORECODE_SEARCHVALUE
- https://www.michaelkors.com/blakely-leather-tote/_/R-US_30S8SZLT3L?color=1999&r8shoplocal=StoreLocator_3456_30019

`SITESECTION` should populate where the click occurred, `STORECODE` should populate the store code clicked from, and `SEARCHVALUE` should contain the value used to generate the store locator results.

## Single Page Applications – Page Change
This example is provided for Michael Kors just in case it becomes necessary. So far, I have not found a specific case where this would be used. This pattern would be executed when a new page is presented to the user in a Single Page Application (SPA) and we’d like to tell Launch about it and pass some information along.

This event simulates the normal process that takes place in a traditional HTML website where a user changes pages by requesting a page via HTTP GET or POST and a new document is sent to the client in response.

When a Single Page Application presents a new page to the user (and not the result of a normal HTTP document request), the following JavaScript should be triggered:

```javascript
// SPA pageChange in example
// create object with eventInfo and page object
var ddPageChangeEvent = {
  eventInfo: {
    eventName: "pageChange",
    type: "navigation",
    timeStamp: new Date(),
    processed: {
      adobeAnalytics: false // Launch will change this to true once processed 
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

## customEvent – Data Layer Complete
This example is provided for Michael Kors because the data layer does not currently exist in it’s complete form prior to Adobe Launch being embedded on the site or may not be able to be fully built prior to the Adobe Launch embed code in the future.

This event will notify Adobe Launch that all applicable components of the data layer have fully loaded, so Adobe Launch will know it’s safe to start evaluating rules for sending analytics or marketing vendor data. This event should be dispatched on every page load, whether it is a “traditional” page load or a SPA page change.

The example below is just the event, and should be executed after any page load data layer scenarios have been instantiated on the page as normal.

```javascript
// data layer ready example
// assuming data layer object already exists and is populated with up to date information
window.mkorsData = {
  page: {/*...*/},
  user: [
    {/*...*/}
  ]
};

// Create and dispatch an event trigger
sendCustomEvent("dataLayerReady");
```

# Testing and Debugging
In order to debug the Launch functionality that has not yet been deployed to production, you will need to install the [Adobe Launch/DTM Switch](https://chrome.google.com/webstore/detail/adobe-dtm-switch/nlgdemkdapolikbjimjajpmonpbpmipk?hl=en) browser extension for Chrome. Set the browser extension to “debug” and “staging” in order to see the staging library and the debug information in the console.

Rules have been (or soon will be) set up in Launch to listen for the specific custom events described in this document to fire in the DOM (on the `BODY` element):
When one of the events is dispatched, you will see the event identified in the browser’s developer console like this: 

![img]()

The first line will identify the event that fired, and the second line will represent the `mkorsData.event` array. The `mkorsData.event` array should be populated before the custom event is dispatched.

# Appendix
## IE8 event polyfill
Below is the polyfill, for the support of custom events on IE8 and IE9. This file is referenced in this document as `ie8eventlistener.min.js`
```javascript
window.Element&&window.Element.prototype.attachEvent&&!window.Element.prototype.addEventListener&&function(){function e(e,t){window.Window.prototype[e]=window.HTMLDocument.prototype[e]=window.Element.prototype[e]=t}function t(e){t.interval&&document.body&&(t.interval=clearInterval(t.interval),document.dispatchEvent(new CustomEvent("DOMContentLoaded")))}e("addEventListener",function(e,t){var n=this,o=n.addEventListener.listeners=n.addEventListener.listeners||{},r=o[e]=o[e]||[];r.length||n.attachEvent("on"+e,r.event=function(e){var t,o,a=n.document&&n.document.documentElement||n.documentElement||{scrollLeft:0,scrollTop:0},i=0,l=[].concat(r),c=!0,d=0;for(e.currentTarget=n,e.pageX=e.clientX+a.scrollLeft,e.pageY=e.clientY+a.scrollTop,e.preventDefault=function(){e.returnValue=!1},e.relatedTarget=e.fromElement||null,e.stopImmediatePropagation=function(){c=!1,e.cancelBubble=!0},e.stopPropagation=function(){e.cancelBubble=!0},e.target=e.srcElement||n,e.timeStamp=+new Date,i=0;c&&(t=l[i]);++i)for(d=0;o=r[d];++d)if(o===t){o.call(n,e);break}}),r.push(t)}),e("removeEventListener",function(e,t){var n,o,r=this,a=r.addEventListener.listeners=r.addEventListener.listeners||{},i=a[e]=a[e]||[];for(o=i.length-1;n=i[o];--o)if(n===t){i.splice(o,1);break}!i.length&&i.event&&r.detachEvent("on"+e,i.event)}),e("dispatchEvent",function(e){var t=this,n=e.type,o=t.addEventListener.listeners=t.addEventListener.listeners||{},r=o[n]=o[n]||[];try{return t.fireEvent("on"+n,e)}catch(a){return void(r.event&&r.event(e))}}),Object.defineProperty(Window.prototype,"CustomEvent",{get:function(){var e=this;return function(t,n){var o,r=e.document.createEventObject();r.type=t;for(o in n)"cancelable"===o?r.returnValue=!n.cancelable: "bubbles"===o?r.cancelBubble=!n.bubbles: "detail"===o&&(r.detail=n.detail);return r}}}),t.interval=setInterval(t,1),window.addEventListener("load",t)}(),(!this.CustomEvent||"object"==typeof this.CustomEvent)&&function(){this.CustomEvent=function(e,t){var n;t=t||{bubbles:!1,cancelable:!1,detail:void 0};try{n=document.createEvent("CustomEvent"),n.initCustomEvent(e,t.bubbles,t.cancelable,t.detail)}catch(o){n=document.createEvent("Event"),n.initEvent(e,t.bubbles,t.cancelable),n.detail=t.detail}return n}}();
```