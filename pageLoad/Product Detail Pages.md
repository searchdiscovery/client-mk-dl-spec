# Product Detail Pages
In addition to `page` and `user` properties, Product Detail Pages have `product` and `crossSellGroup` arrays.

Note that on PDPs, members of `product` have the `SkuVariants` array.

## Code Example
```javascript
window.mkorsData = {
  page: {
    breadcrumb: "<breadcrumb>",
    channel: "<channel>",
    countryLanguage: "<countryLanguage>",
    name: "<name>",
    navigation: "<navigation>",
    region: "<region>",
    responsiveView: "<responsiveView>",
    siteSectionLevel2: "<siteSectionLevel2>",
    siteSectionLevel3: "<siteSectionLevel3>",
    siteType: "<siteType>",
    type: "<type>"
  },
  product: {
    SkuVariants: [
      {
        availability: "<availability>",
        basePrice: "<basePrice>",
        color: "<color>",
        pricePer: "<pricePer>",
        priceType: "<priceType>",
        productID: "<productID>",
        size: "<size>"
      }
    ],
    availability: "<availability>",
    basePrice: "<basePrice>",
    categoryID: "<categoryID>",
    categoryName: "<categoryName>",
    color: "<color>",
    crossSellCartridge: "<crossSellCartridge>",
    gwp: "<gwp>",
    gwpSku: "<gwpSku>",
    isCrossSell: "<isCrossSell>",
    keywords: "<keywords>",
    mfr: "<mfr>",
    mfrItemNum: "<mfrItemNum>",
    name: "<name>",
    pricePer: "<pricePer>",
    priceType: "<priceType>",
    productID: "<productID>",
    qtyAvailable: "<qtyAvailable>",
    upc: "<upc>",
    isEngravable: "<isEngravable>",
    isMonogrammable: "<isMonogrammable>"
  },
  crossSellGroup: [
    {
      strategy: "<strategy>",
      productCount: "<productCount>",
      product: [
        {
          displayIndex: "<displayIndex>",
          mfr: "<mfr>",
          mfrItemNum: "<mfrItemNum>",
          productID: "<productID>"
        }
      ]
    }
  ],
  user: [
    {
      profile: [
        {
          profileInfo: {
            applePayEnabled: "<applePayEnabled>",
            customerType: "<customerType>",
            hashedID: "<hashedID>",
            hashedID2: "<hashedID2>",
            loginStatus: "<loginStatus>",
            loyaltyTier: "<loyaltyTier>",
            type: "<type>"
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
|breadcrumb|string|Yes|Path to current page|`"/sloan-tango-small-quilted-leather-shoulder-bag/_/R-US_12AB34CD56EF"`|
|channel|string|Yes|Marketing channel|`"HANDBAGS"`|
|countryLanguage|string|Yes|i18n language|`"US:en"`|
|name|string|Yes|Name of current page|`"Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag"`|
|navigation|string|No|Global navigation path|`"MK:Top Nav > WOMEN > HANDBAGS > SHOULDER BAGS"`|
|region|string|Yes|Geographic region|`"NA"`, `"EU"`|
|responsiveView|string|Yes|Responsive view size|`"xsmall"`, `"small"`, `"medium"`, `"large"`|
|siteSectionLevel2|string|No||`"Home > HANDBAGS"`|
|siteSectionLevel3|string|No||`"Home > HANDBAGS > SHOULDER BAGS > SloanTangoSmallQuilted-LeatherShoulderBag"`|
|siteType|string|No|Legacy site type|`"responsive:ecommerce"`|
|type|string|Yes|Type of page|`"Home Page"`|

## Product Properties
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Base unit price of item|`445.0`|
|categoryID|string|SFCC category ID|`"cat20009"`|
|categoryName|string|Name of category|`"NEW ARRIVALS"`|
|customized|boolean|Whether or not the item has been customized|`true`, `false`|
|color|string|Color code|`"BLACK"`|
|crossSellCartridge|string|||
|customized|boolean|Whether or not the item has been customized|`true`, `false`|
|gwp|string||`"N"`|
|gwpSku|string|||
|isCrossSell|string|Whether or not the item is cross sell eligible||
|isEngravable|string|Whether or not the item is engravable||
|isMonogrammable|string|Whether or not the item is monogrammable||
|mfr|string|Manufacturer of the item||
|mfrItemNum|string|ID used by manufacturer||
|name|string|Product name|`"SloanTangoSmallQuilted-LeatherShoulderBag"`|
|pricePer|number|Displayed unit price of item||
|priceType|string|Type of price displayed to user|`"List"`, `"Markdown"`|
|productID|string|Product ID|`"4952115"`|
|size|string|Size code|`"LARGE"`, `"12"`|
|skuVariants|array|See SKU Variants Array below||
|upc|string|Universal purchase code ID||

### SKU Variants Array
The SKU Variants array contains objects which have a subset of Product properties, and which describe variants of the displayed product. For example, if a pair of boots is available in multiple colors, the default information is loaded in the main `products` object, and details about variants are loaded as objects in the `SkuVariants` array.

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|basePrice|number|Base unit price of item|`445.0`||||0.00|||
|color|string|Color code|`"BLACK"`, `"RED/BROWN"`|
|pricePer|number|Displayed unit price of item|`445.0`|
|priceType|string|Type of price displayed to user|`"Markdown"`|
|productID|string|Product ID|`"4952115"`|
|size|string|Size code|`"ONE SIZE"`, `"LARGE"`, `"12"`|

## Cross Sell Group Properties
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|productCount|string|Number of products in the group|`"3"`|
|strategy|string|Cross sell strategy used|`"We Think You Will Love"`, `"Recently Viewed"`|

### Cross Sell Group Product Properties
The members of the Cross Sell Group array are subsets of the `product` object.
|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|displayIndex|integer|Order in which the item was displayed|`0`, `1`, `2`|
|mfr|string|Manufacturer of the item||
|mfrItemNum|string|ID used by manufacturer||
|productID|string|Product ID|`"4952115"`|

## Notes
1. The `mkorsData.page.type` value should reflect product configurator values as well, such as “Product Detail Monogramming” and “Product Detail Engraving”.