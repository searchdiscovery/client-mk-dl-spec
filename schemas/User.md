# User
The `user` array describes one or more user profiles of one or more users who have logged into the site using the current browser.

Due to the way [the CEDDL spec](https://www.w3.org/2013/12/ceddl-201312.pdf) is written, this may be a bit confusing.

## Code Example
```json
{
  "user": [
    {
      "profile": [
        {
          "profileInfo": {
            "applePayEnabled": true,
            "customerType": "customer",
            "emailOptIn": true,
            "hashedID": "7ddb5eae16468674b843f396b335a7dd",
            "hashedID2": "jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4",
            "loginStatus": "logged_in",
            "loyaltyOptIn": true,
            "loyaltyTier": "studio",
            "type": "registered"
          }
        }
      ]
    }
  ]
}
```

## User Properties
The `user` array contains objects which describe individual users. In most cases there will only ever be a single object.

## Profile Properties
The `profile` array contains objects which describe one or more profiles associated with a user. Again, this will almost always be one. Objects in this array themselves have only a single property, `profileInfo` (see below).

## Profile Info Properties
|Field|Type|Required|Description|Examples|Pattern|Min Length|Max Length|Min|Max|Multiple Of|
|-----|----|-----------|--------|-------|----------|----------|---|---|-----------|---|
|applePayEnabled|boolean|Yes if logged in|Whether or not the user has Apple Pay enabled|`true`, `false`|
|customerType|string|Yes if logged in|Customer type|`"customer"`, `"employee"`, `"associate"`|
|emailOptIn|boolean|Yes if logged in|Whether the user has confirmed email opt in|`true`, `false`|
|hashedID|string|Yes if logged in|md5 hash of email address|`"7ddb5eae16468674b843f396b335a7dd"`|
|hashedID2|string|Yes if logged in|sha256 hash of email address|`"jknhjbebgo8y5oy6obv7b6bo8wowobv8757384ybof87bv5g4"`|
|loginStatus|string|Yes|Customer login status|`"logged_in"`, `"logged_out"`|
|loyaltyOptIn|boolean|Yes if logged in|Whether the user has opted into the MK customer loyalty program|`true`, `false`|
|loyaltyTier|string|Yes if logged in|Customer loyalty tier|`"studio"`, `"backstage"`, `"runway"`, `"red_carpet"`, `"non-loyalty"`|
|type|string|Yes|User type|`"guest"`, `"registered"`, `"loyalist"`|