# Product
The `product` array is an array of one more more objects, each describing a single product displayed on a page or screen.

Depending on the context, objects in the `product` array may contain additional properties (e.g. `pickUpInStore` is only applicable upon order confirmation). However, there is core set of properties which must always be present in order for accurate data collection to take place.

## Code Example
```js
window.mkorsData = {
  product: [
    {
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
      isEngravable: "<isEngravable>",
      isMonogrammable: "<isMonogrammable>",
      keywords: "<keywords>",
      lookID: "<lookID>",
      mfr: "<mfr>",
      mfrItemNum: "<mfrItemNum>",
      name: "<name>",
      pickUpInStore: "<pickUpInStore>",
      pickUpStoreID: "<pickUpInStore>",
      pickUpStoreName: "<pickUpStoreName>",
      pricePer: "<pricePer>",
      priceType: "<priceType>",
      productID: "<productID>",
      qtyAvailable: "<qtyAvailable>",
      quantity: "<quantity>",
      shippingMethod: "<shippingMethod>",
      storeID: "<storeID>",
      upc: "<upc>"
    }
  ]
};
```

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|basePrice|number|Yes|Base unit price of item|`445.0`|
|categoryID|string|Yes|SFCC category ID|`"cat20009"`|
|categoryName|string|Yes|Name of category|`"new_arrivals"`|
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|
|color|string|Only if the product has a color choice|Color code|`"black"`|
|crossSellCartridge|string|?|?|
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|
|gwp|boolean|?|?|`true`, `false`
|gwpSku|string|?|?|
|isCrossSell|boolean|Yes|Whether or not the item is cross sell eligible||
|isEngravable|boolean|Yes|Whether or not the item is engravable||
|isMonogrammable|boolean|Yes|Whether or not the item is monogrammable||
|lookID|string|No|If available, which look the item is associated with||
|mfr|string|Yes|Manufacturer of the item||
|mfrItemNum|string|Yes|ID used by manufacturer||
|name|string|Yes|Product name|`"SloanTangoSmallQuilted-LeatherShoulderBag"`|
|pickUpInStore|boolean|Only on Order Confirmation screen|Whether the customer chose to pick up the item at the store instead of having it shipped|`true`, `false`|
|pickUpStoreID|string|Only if `pickUpInStore` is `true`|The ID of the store where the customer chose to pick up the item|`"637"`|
|pickUpStoreName|string|Only if `pickUpInStore` is `true`|The name of the store where the customer chose to pick up the item|`"MICHAEL KORS TACOMA"`|
|pricePer|number|Yes|Displayed unit price of item||
|priceType|string|Yes|Type of price displayed to user|`"list"`, `"markdown"`|
|productID|string|Yes|Product ID|`"4952115"`|
|qtyAvailable|number|No|How many of the item is left in stock|`23`|
|quantity|number|No|How many of the item were added to the cart|`1`|
|size|string|Only if product has a size choice|Size code|`"large"`, `"12"`|
|shippingMethod|string|Only where available|The method by which the customer chose to have the item shipped|`"ground"`, `"next_day"`, `"pickup"`|
|storeID|string|No|ID of the store where the customer chose to pick up the item<br><br><strong>NOTE: this conflicts with `pickUpStoreID` above!</strong>|
|upc|string|Yes|Universal purchase code ID|

## JSON Schema
```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "title": "Product",
    "type": "object",
    "properties": {
      "basePrice": {
        "type": "number"
      }
    },
    "additionalProperties": false,
    "required": ["basePrice"]
}
```