# Shopping Cart Page
The **Shopping Cart Page** will have the following data layer JSON object.

## Code Example

```javascript
window.mkorsData = {
  page: {
    breadcrumb: "/checkout/shoppingCart.jsp",
    channel: "Shopping Cart",
    countryLanguage: "US:en",
    currency: "USD",
    name: "Shopping Cart",
    siteSectionLevel2: "Shopping Cart",
    siteSectionLevel3: "Shopping Cart",
    siteType: "desktop:ecommerce",
    responsiveView: "large",
    type: "Shopping Cart"
  },
  cart: {
    product: [
      {
        available: "Y",
        basePrice: "145.0",
        category: "Boots",
        categoryID: "cat20125",
        color: "BROWN",
        crossSellCartridge: "",
        customized: "false",
        engraved: "false" // "true" or "false" if a product is engraved
        gwp: "N",
        gwpSku: "",
        isBaseItem: "",
        isCrossSell: "N",
        mfr: "Michael Kors",
        mfrItemNum: "CB99A5G0UK",
        monogrammed: "true",
        name: "KekeExtremeLogoTapeBoot",
        orderType: "regular", // "regular" or "preorder" depending on order type
        outfitID: "28415181",
        pickUpInStore: "N",
        pickUpStoreID: "",
        pickUpStoreName: "",
        pricePer: "145.0",
        priceType: "List",
        productID: "831879309",
        qty: "2",
        size: "US 9",
        sku: "551269803",
        upc: "888318793094",
      }
    ]
  },
  crossSellGroup: [
    {
      product: [
        {
          displayIndex: 1
          mfr: "Michael Kors Studio",
          mfrItemNum: "30H6SOAL2L",
          productID: "13452115",
        },
        {
          displayIndex: 2
          mfr: "Michael Kors",
          mfrItemNum: "10X6SOAL34",
          productID: "134521755",
        }
      ],
      productCount: 4,
      strategy: "You may also like"
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
  ],
  user: [
    {
      profile: [
        {
          profileInfo: {
            applePayEnabled: "true" // true or false (added for ECB-13327)
            customerType: "Customer", // "Customer", "Employee", "Associate"
            hashedID: "7ddb5eae16468674b843f396b335a7dd", // md5 hash of email address
            hashedID2: "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4", // sha256 hash of email address
            loginStatus: "logged In", // "logged in", "logged out"
            // string indication of tier - set to "down" if 500 friends service is unavailable
            loyaltyTier: "studio", // "backstage", "runway", "red carpet", "non-loyalty"
            type: "registered", // "guest", "registered", "loyalist"
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

## Cart Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|---|--------|-------|----------|----------|---|---|-----------|
|currency|string|Yes|Currency code|`"USD"`|
|customerID|string|No|Customer ID|
|customerType|string|No|Customer type|
|product|array|Yes|See below for `product` properties|

## Product Properties
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Base unit price of item|`445.0`|||||||
|categoryID|string|SFCC category ID|`"cat20009"`|||||||
|categoryName|string|Name of category|`"NEW ARRIVALS"`|||||||
|customized|boolean|Whether or not the item has been customized|`true`, `false`|||||||
|color|string|Color code|`"BLACK"`|||||||
|crossSellCartridge|string|||||||||
|customized|boolean|Whether or not the item has been customized|`true`, `false`|||||||
|gwp|string||`"N"`|||||||
|gwpSku|string|||||||||
|isCrossSell|string|Whether or not the item is cross sell eligible||||||||
|isEngravable|string|Whether or not the item is engravable||||||||
|isMonogrammable|string|Whether or not the item is monogrammable||||||||
|mfr|string|Manufacturer of the item||||||||
|mfrItemNum|string|ID used by manufacturer||||||||
|name|string|Product name|`"SloanTangoSmallQuilted-LeatherShoulderBag"`|||||||
|pricePer|number|Displayed unit price of item||||||||
|priceType|string|Type of price displayed to user|`"List"`, `"Markdown"`|||||||
|productID|string|Product ID|`"4952115"`|||||||
|size|string|Size code|`"LARGE"`, `"12"`|||||||
|skuVariants|array|See SKU Variants Array below||||||||
|upc|string|Universal purchase code ID||||||||

## Cross Sell Group Properties
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|productCount|string|Number of products in the group|`"3"`|||||||
|strategy|string|Cross sell strategy used|`"We Think You Will Love"`, `"Recently Viewed"`|||||||

### Cross Sell Group Product Properties
The members of the Cross Sell Group array are subsets of the `product` object.
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|displayIndex|integer|Order in which the item was displayed|`0`, `1`, `2`|||||||
|mfr|string|Manufacturer of the item||||||||
|mfrItemNum|string|ID used by manufacturer||||||||
|productID|string|Product ID|`"4952115"`|||||||

## Notes

1. Present Launch page load is scraping the DOM to align price info with products in the data layer. It’s super fragile and WILL break.
2. The addition of Kors Custom items (with `baseItems` and outfit groupings) has made the DOM scraping more difficult and trouble prone.
3. The addition of “The Look” has added to the complexity.
4. `priceType` by product has been on the list for inclusion for quite some time.
5. I anticipate that shipping method (ship to store vs ship to address) will also be an ask from the analytics team.
6. Present Launch code does not track `crossSells` shown at the bottom of the cart. An object is added here, matching the structure of `crossSells` on PDP.


I would suggest that we have a discussion around what data exists in the application state about shopping carts and the products within? If we had this understanding, we could better advise the mapping to the data layer.