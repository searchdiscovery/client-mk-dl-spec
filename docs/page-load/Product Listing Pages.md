# Product Listing Pages
**Product Listing Pages** include product listings as a result of category navigation as well as search results. When product listing pages are first loaded, a page data layer is created as shown below.  In most cases, we will have a result count, a default sort order and pagination information, but we will not have refinements already applied. However, it is assumed that we could have a page loaded with refinements applied as the result of a shared or bookmarked link or a page refresh. As such, the refinements array is included below.


## Code Example
```javascript
window.mkorsData = {
  page: {
    breadcrumb: "/shoes/ankle-boots/_/N-180msnr",
    channel: "SHOES",
    countryLanguage: "US:en",
    currencyCode: "USD",
    dmpCategory: "Ankle Boots",
    merchCategoryLevel1: "SHOES",
    merchCategoryLevel2: "Home > SHOES > ANKLE BOOTS",
    merchCategoryLevel3: "Home > SHOES > ANKLE BOOTS",
    name: "Home > SHOES > ANKLE BOOTS",
    navigation: "MK:Top Nav > SHOES > ANKLE BOOTS",
    region: "US",
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
    query: "",
    queryReplaced: ""
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            applePayEnabled: true,
            customerType: "customer",
            hashedID: "7ddb5eae16468674b843f396b335a7dd",
            hashedID2: "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4",
            loginStatus: "logged_in",
            loyaltyTier: "studio",
            type: "registered"
          }
        }
      ]
    }
  ]
}
```

## Page Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|---|--------|-------|----------|----------|---|---|-----------|
|breadcrumb|string|Yes|Path to current page|`"/sloan-tango-small-quilted-leather-shoulder-bag/_/R-US_12AB34CD56EF"`|||||||
|channel|string|Yes|Marketing channel|`"HANDBAGS"`|||||||
|countryLanguage|string|Yes|i18n language|`"US:en"`|||||||
|name|string|Yes|Name of current page|`"Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag"`|||||||
|navigation|string|No|Global navigation path|`"MK:Top Nav > WOMEN > HANDBAGS > SHOULDER BAGS"`|||||||
|region|string|Yes|Geographic region|`"NA"`, `"EU"`|||||||
|responsiveView|string|Yes|Responsive view size|`"xsmall"`, `"small"`, `"medium"`, `"large"`|||||||
|siteSectionLevel2|string|No||`"Home > HANDBAGS"`|||||||
|siteSectionLevel3|string|No||`"Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag"`|||||||
|siteType|string|No|Legacy site type|`"responsive:ecommerce"`|||||||
|type|string|Yes|Type of page|`"Home Page"`|||||||

## Notes

It is desirable to have sorting and refinement information provided in English regardless of the end user’s language selection. Subsequent refinements or sort order selections after page load will be tracked via custom events (see [customEvent - PLP Refinements](#customevent---plp-refinements)).