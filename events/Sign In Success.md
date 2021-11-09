# Sign In Success
Executed when a customer successfully signs in to an existing account. 

## Code Example

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
            customerType: "customer",
            emailOptIn: true,
            hashedID: "7ddb5eae16468674b843f396b335a7dd",
            hashedID2: "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4"
            loginStatus: "logged_in",
            loyaltyTier: "studio",
            type: "registered",
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

## Event Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|--------|-----------|--------|-------|----------|----------|---|---|-----------|
|eventName|string|Yes|The name of the event|`"signInSuccess"`|
|type|string|Yes|The event type|`"account"`|
|timeStamp|string|Yes|ISO-8601 Extended Format date|`"2021-11-05T20:22:02.707Z"`|
|processed|object|Yes|Contains one property, `adobeAnalytics`, always set to `false` by application, but which is updated by Launch upon processing|`false`|

## User Properties
The `user` array contains objects which describe individual users. In most cases there will only ever be a single object.

### Profile Properties
The `profile` array contains objects which describe one or more profiles associated with a user. Again, this will almost always be one. Objects in this array themselves have only a single property, `profileInfo` (see below).

### Profile Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|customerType|string|Yes if logged in|Customer type|`"customer"`, `"employee"`, `"associate"`|
|emailOptIn|boolean|Yes if logged in|Whether the user has confirmed email opt in|`true`, `false`|
|hashedID|string|Yes if logged in|md5 hash of email address|`"7ddb5eae16468674b843f396b335a7dd"`|
|hashedID2|string|Yes if logged in|sha256 hash of email address|`"jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4"`|
|loginStatus|string|Yes|Customer login status|`"logged_in"`, `"logged_out"`|
|loyaltyTier|string|Yes if logged in|Customer loyalty tier|`"studio"`, `"backstage"`, `"runway"`, `"red_carpet"`, `"non-loyalty"`|
|type|string|Yes|User type|`"guest"`, `"registered"`, `"loyalist"`|

## Notes
The `hashedID`s in the `user[n].profile[n]` object are one-way hashes of the customer’s email address. This value is fed into the analytics data stream (and also into a few marketing pixels) for the purpose of visitor stitching across devices and back-end matching of online data to CRM data.

Both the MD5 and SHA256 algorithms are used for hashing. The same algorithms must be used in all back-end systems in order for matching to work. Whatever the hashing (or encryption) process, be sure to standardize the plain-text email address format before processing; This means forcing the string to lowercase and encode special characters (if any). Also, be certain to document the full process and follow it to the letter on all systems that will convert customer IDs (email or otherwise) into hashed or encrypted keys.