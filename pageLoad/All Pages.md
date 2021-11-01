# All Pages
There is basic information that should be included in the digital data layer on all pages of the web site. This data is provided in a JSON object and is used by Adobe Launch to determine which (if any) rules should fire and what data should be sent in analytics and marketing tags. 
A good practice is to create this object in server side code, convert it to JSON, and include it in an inline script tag of the HTML markup so that the actual `window.mkorsData` object is instantiated as the page renders in the client-side browser.

Below is an example of the core `mkorsData` object that is expected on all website pages.
- Note the absence of the `tagConfig` object; we no longer rely on this for Adobe Launch config.
- Also note the inclusion of the user object.

## Code Example

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


## Notes

1. `mkorsData.page.siteType` will have no purpose once the site is fully responsive and if the Destination Kors site goes away. Set to `responsive:ecommerce` for site redesign (PDP, PLP, SERP, Home).
2. `mkorsData.page.responsiveView` is provided for site redesign to carry the responsive view of the page at the time it is loaded. The value might be `xsmall`, `small`, `medium`, or `large` depending on how many responsive breakpoints there are.
3. See notes on the `hashedID` that are included in this document on the Sign In Success custom event. (md5 hash of trimmed, lowercased, email address)
4. [ECB-13327](https://mk-jira.sparkred.com/browse/ECB-13327) Added `mkorsData.user[n].profile[n].profileInfo.applePayEnabled: /true|false/`