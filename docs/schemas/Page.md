# Page
The `page` object is the basic building block of all pages. It should be present on every page of the site. It contains basic information that is required for accurate pageview tracking.

## Code Example

```js
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
    }
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

## JSON Schema
```json
{
    "$schema": "http://json-schema.org/draft-07/schema#",
    "title": "Page",
    "type": "object",
    "properties": {
        "breadcrumb": {
            "type": "string"
        },
        "channel": {
            "type": "string"
        },
        "countryLanguage": {
            "type": "string"
        },
        "name": {
            "type": "string"
        },
        "navigation": {
            "type": "string"
        },
        "region": {
            "type": "string"
        },
        "responsiveView": {
            "enum": [
                "xsmall",
                "small",
                "medium",
                "large"
            ],
            "type": "string"
        },
        "siteSectionLevel2": {
            "type": "string"
        },
        "siteSectionLevel3": {
            "type": "string"
        },
        "siteType": {
            "type": "string"
        },
        "type": {
            "type": "string"
        }
    },
    "additionalProperties": false,
    "required": [
        "breadcrumb",
        "channel"
    ]
}
```