# Order Confirmation Page
The Order Confirmation Page will have the following data layer JSON object.

## Code Example

```javascript
window.mkorsData = {
  page: {
    channel: "checkout",
    countryLanguage: "US:en",
    name: "checkout:confirmation",
    responsiveView: "medium"
    siteSectionLevel2: "checkout:confirmation",
    siteSectionLevel3: "checkout:confirmation",
    siteType: "desktop:ecommerce",
    type: "checkout:confirmation",
  },
  transaction: {
    billingCountry: "US",
    billingState: "WI",
    billingZipCode: "53533-8825",
    currency: "USD",
    customerID: "13466870",
    customerType: "0",
    nonProductGwp: "",
    orderDiscountAmount: 0.00,
    orderID: "w8244902",
    orderType: "regular", // "regular" or "preorder" depending on order type
    paymentMethod: "visa",
    product: [
      {
        color: "ELECTRIC BLUE",
        category: "NEW ARRIVALS",
        categoryID: "cat3240085",
        mfr: "Michael Kors Studio",
        mfrItemNum: "30F6SM9T3L",
        name: "MercerLargeLeatherTote",
        pricePer: 298.0,
        priceType: "List",
        productID: "86448190",
        qty: 1,
        customized: true,
        outfitID: "35185404",
        isBaseitem: true,
        isCrossSell: false,
        productDiscountAmount: 0.0,
        giftwrapAmount: 0.0,
        markdownAmount: 0.0,
        size: "ONE SIZE",
        sku: "86448190",
        upc: "000000190864481906",
        gwpSku: null,
        gwp: false,
        pickUpInStore: true,
        pickUpStoreID: "637",
        pickUpStoreName: "MICHAEL KORS TACOMA",
        monogrammed: true,
        engraved: false
      }
    ],
    salesTax: 24.53,
    shippingCity: "DODGEVILLE",
    shippingCost: 5.00,
    shippingCountry: "US",
    shippingMethod: "ground",
    shippingState: "WI",
    shippingType: "ground"
    shippingZipCode: "53533-8825",
  },
  user: [
    {
      profile: [
        {
          profileInfo: {
            applePayEnabled: true,
            hashedID: "7a8e1e3e9a2116bd77e4f92ed60b1ae7",
            loginStatus: "logged in",
            loyaltyTier: "NA",
            type: "registered",
          }
        }
      ]
    }
  ],
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

## Transaction Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|---|--------|-------|----------|----------|---|---|-----------|
|billingCountry|string|Yes|Country in which purchase was made|`"US"`|
|billingState|string|Yes|State in which purchase was made|`"WI"`|
|billingZipCode|string|Yes|Zip/postal code where purchase was made|`"53533-8825"`|
|currency|string|Yes|Currency in which purchase was made|`"USD"`|
|customerID|string|Yes|Customer ID|`"13466870"`|
|customerType|string|Yes|Customer type|`"0"`|
|nonProductGwp|?|?|?|
|orderDiscountAmount|number|Yes|Total discount applied to purchase|`0.00`|
|orderID|string|Yes|Globally unique identifier for purchase|`"w8244902"`|
|orderType|string|Yes|Order type|`"regular"`, `"preorder"`|
|paymentMethod|string|Yes|Payment method used to make the purchase|`"visa"`, `"apple_pay"`|
|product|array|Yes|Products included in purchase. See below for `product` properties|
|salesTax|number|Yes|Total sales tax applied to purchase|`24.53`|
|shippingCity|string|Yes|City to which purchase will be shipped|`"DODGEVILLE"`
|shippingCost|number|Yes|Shipping cost of entire purchase|`5.00`|
|shippingCountry|string|Yes|Country to which purchase will be shipped|`"US"`|
|shippingMethod|string|Yes|Shipping method chosen by customer|`"ground"`, `"express"`|
|shippingState|string|Yes|State/province to which purchase will be shipped|`"WI"`|
|shippingType|string|Yes|Shipping type chosen by customer |`"ground"`, `"express"`|
|shippingZipCode|string|Yes|Zip/postal code to which order will be shipped|`"53533-8825"`|

## Product Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|basePrice|number|Yes|Base unit price of item|`445.0`|||||||
|categoryID|string|Yes|SFCC category ID|`"cat20009"`|||||||
|categoryName|string|Yes|Name of category|`"NEW ARRIVALS"`|||||||
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|||||||
|color|string|Only if the product has a color choice|Color code|`"BLACK"`|||||||
|crossSellCartridge|string|?|?|||||||
|customized|boolean|Yes|Whether or not the item has been customized|`true`, `false`|||||||
|gwp|boolean|?|?|`true`, `false`||||||
|gwpSku|string|?|?|||||||
|isCrossSell|boolean|Yes|Whether or not the item is cross sell eligible||||||||
|isEngravable|boolean|Yes|Whether or not the item is engravable||||||||
|isMonogrammable|string|Yes|Whether or not the item is monogrammable||||||||
|mfr|string|Yes|Manufacturer of the item||||||||
|mfrItemNum|string|Yes|ID used by manufacturer||||||||
|name|string|Yes|Product name|`"SloanTangoSmallQuilted-LeatherShoulderBag"`|||||||
|pickUpInStore|boolean|Yes|Whether the customer chose to pick up the item at the store instead of having it shipped|`true`, `false`|
|pickUpStoreID|string|Only if `pickUpInStore` is `true`|The ID of the store where the customer chose to pick up the item|`"637"`|
|pickUpStoreName|string|Only if `pickUpInStore` is `true`|The name of the store where the customer chose to pick up the item|`"MICHAEL KORS TACOMA"`|
|pricePer|number|Yes|Displayed unit price of item||||||||
|priceType|string|Yes|Type of price displayed to user|`"List"`, `"Markdown"`|||||||
|productID|string|Yes|Product ID|`"4952115"`|||||||
|size|string|Only if product has a size choice|Size code|`"LARGE"`, `"12"`|||||||
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
1. At present Launch is scraping the DOM determine and set the `product[n].monogrammed` flag. It’s super fragile and WILL break.
2. `mkorsData.transaction.product[2].pickupstoreid` is shown above to demonstrate how the pick up in store (Click &amp; Collect) information may be passed.
3. In the spec above, `transaction.product` is an array of product objects. This aligns with the rest of the data layer where we use an array of products (e.g. `addToBag` for custom items). The present (as of 9/2017) implementation of products within the `transaction` object is an “associative array” instead of an array object. In Launch we are looping through the associative array using
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