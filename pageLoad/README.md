## Page Load Tracking
There is basic information that should be included in the digital data layer on all pages of the web site. This data is provided in a JSON object and is used by Adobe Launch to determine which (if any) rules should fire and what data should be sent in analytics and marketing tags. 
The best practice is to create this object in server side code, convert it to JSON, and include it in an in-line script tag of the HTML markup so that the actual `window.mkorsData` object is instantiated as the page renders in the client-side browser.

Below is an example of the core `mkorsData` object that is expected on all website pages. 
Note the absence of the `tagConfig` object; we no longer rely on this for Adobe Launch config. Also note the inclusion of the user object.

## JavaScript Code

```javascript
// mkorsData page load info for all pages
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
};
```

## Page Properties

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|breadcrumb|string|Path to current page|`"home.html"`|||||||
|channel|string|Marketing channel|`"Home Page"`|||||||
|countryLanguage|string|i18n language|`"US:en"`|||||||
|name|string|Name of current page|`"Home Page"`|||||||
|navigation|string|Global navigation path|`"MK:Top Nav > WOMEN > HANDBAGS > SHOULDER BAGS"`|||||||
|region|string|Geographic region|`"NA"`, `"EU"`|||||||
|responsiveView|string|Responsive view size|`"xsmall"`, `"small"`, `"medium"`, `"large"`|||||||
|siteSectionLevel2|string|||||||||
|siteSectionLevel3|string|||||||||
|siteType|string|Site type|`"responsive:ecommerce"`|||||||
|type|string|Type of page|`"Home Page"`|||||||

## User Profile Properties
The [CEDDL spec](https://www.w3.org/2013/12/ceddl-201312.pdf) is a little confusing here but intends to account for scenarios where multiple users might be using the same client to access the site, and/or where a single user might have multiple user profiles.
- `user` is always an array containing one or more objects, each representing a single user.
- `profile` is always an array containing one or more objects, each representing a single user profile.
- Sites which do not support multiple users or profiles will always have one object for each.

|Field|Type|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|
|applePayEnabled|string|Whether or not the current user has enabled ApplePay for purchases|`"true"`|||||||
|customerType|string|Type of customer|`"Customer"`, `"Employee"`, `"Associate"`|||||||
|hashedID|string|md5 hash of email address|`"7ddb5eae16468674b843f396b335a7dd"`|||||||
|hashedID2|string|sha256 hash of email address|`"jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4"`|||||||
|loginStatus|string|Whether or not the user is logged in|`"logged in"`, `"logged out"`|||||||
|loyaltyTier|string|Customer loyalty tier status|`"backstage"`, `"runway"`, `"red carpet"`, `"non-loyalty"`|||||||
|type|string||`"guest"`, `"registered"`, `"loyalist"`|||||||