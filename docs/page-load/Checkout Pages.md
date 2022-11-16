# Checkout Pages
The Checkout pages will have the following data layer JSON object.

## Code Example

```javascript
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
|currency|
|customerID|
|customerType|
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