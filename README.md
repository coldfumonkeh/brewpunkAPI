# BREW PUNK API

This is a CFC wrapper to interact with the Brew Punk API ( https://punkapi.com ).

No authentication is needed but the API is rate-limited to 3600 requests per hour.

Available methods are:

* `getBeers()`
* `getBeer()`
* `getRandomBeer()`

Additional methods:

Each request updates the number of requests remaining within the rate-limit period.
You can fetch this value using the `getRateLimitRemaining()` method.


## JSON string or deserialized array

All methods in the wrapper allow you to get the response as a deserialized array for server-side processing. To enable this simply set the `parseResponse` parameter to `true`.


## getBeers()

The `getBeer()` method accepts a number of properties to help you filter results:

`abv_gt`

Returns all beers with ABV greater than the supplied number

`abv_lt`	

Returns all beers with ABV less than the supplied number

`ibu_gt`

Returns all beers with IBU greater than the supplied number

`ibu_lt`

Returns all beers with IBU less than the supplied number

`ebc_gt`

Returns all beers with EBC greater than the supplied number

`ebc_lt`

Returns all beers with EBC less than the supplied number

`beer_name`

Returns all beers matching the supplied name (this will match partial strings as well so e.g punk will return Punk IPA), if you need to add spaces just add an underscore (`_`).

`yeast`

Returns all beers matching the supplied yeast name, this performs a fuzzy match, if you need to add spaces just add an underscore (`_`).

`brewed_before`

Returns all beers brewed before this date. The date format is mm-yyyy e.g 10-2011

`brewed_after`

Returns all beers brewed after this date. The date format is mm-yyyy e.g 10-2011

`hops`

Returns all beers matching the supplied hops name, this performs a fuzzy match, if you need to add spaces just add an underscore (`_`).

`malt`

Returns all beers matching the supplied malt name, this performs a fuzzy match, if you need to add spaces just add an underscore (`_`).

`food`

Returns all beers matching the supplied food string, this performs a fuzzy match, if you need to add spaces just add an underscore (`_`).

`ids`

Returns all beers matching the supplied ID's. You can pass in multiple ID's by separating them with a `|` symbol.