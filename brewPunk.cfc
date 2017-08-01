component accessors="true" {

	property name="endpoint" type="string" default="https://api.punkapi.com/v2/";
	property name="rateLimit" type="string" default="3600";
	property name="rateLimitRemaining" type="string" default="3600";

	/**
	* Constructor
	*/
	public function init(){
		return this;
	}

	/**
	* Get all beers from the API.
	* @parseResponse If true the data will be returned in a parsed format.
	*/
	public function getBeers(
		numeric page,
		numeric per_page,
		numeric abv_gt,
		number abv_lt,
		number ibu_gt,
		number ibu_lt,
		number ebc_gt,
		number ebc_lt,
		string beer_name,
		string yeast,
		string brewed_before,
		string brewed_after,
		string hops,
		string malt,
		string food,
		string ids,
		boolean parseResponse = false
	){
		var sParams = structCopy( arguments );
		structDelete( sParams, 'parseResponse' );
		return makeRequest(
			url           = getEndpoint() & 'beers' & buildParamString( clearEmptyParams( sParams ) ), 
			parseResponse = arguments.parseResponse
		);
	}

	/**
	* Gets a beer from the API using the beer id.
	* @beerID The beer id.
	* @parseResponse If true the data will be returned in a parsed format.
	*/
	public function getBeer(
		required numeric beerID,
		boolean parseResponse = false
	){
		return makeRequest(
			url           = getEndpoint() & 'beers/' & arguments.beerID,
			parseResponse = arguments.parseResponse
		);
	}

	/**
	* Gets a random beer from the API.
	* @parseResponse If true the data will be returned in a parsed format.
	*/
	public function getRandomBeer(
		boolean parseResponse = false
	){
		return makeRequest(
			url           = getEndpoint() & 'beers/random',
			parseResponse = arguments.parseResponse
		);
	}

	/**
	* Makes the request to the API.
	* @url The URL to make the request to.
	* @parseResponse If true the data will be returned in a parsed format.
	*/
	public function makeRequest(
		required string url,
		boolean parseResponse
	){
		var stuResponse = {};
		var httpService = new http(); 
	    httpService.setMethod( "get" ); 
	    httpService.setCharset( "utf-8" ); 
	    httpService.setUrl( arguments.url );
	    var result = httpService.send().getPrefix();
	    var sResponseHeader = result.ResponseHeader;
	    if( '200' == sResponseHeader[ 'status_code' ] ) {
	    	setRateLimit( sResponseHeader[ 'X-RateLimit-Limit' ] );
	    	setRateLimitRemaining( sResponseHeader[ 'X-RateLimit-Remaining' ] );
	    	stuResponse.success = true;
	    	stuResponse.content = ( arguments.parseResponse ) ? deserializeJSON( result.FileContent ) : result.FileContent;
	    } else {
	    	stuResponse.success = false;
	    	stuResponse.content = result.Statuscode;
	    }
    	return stuResponse;
	}

	/**
	* I return a string containing any extra URL parameters to concatenate and pass through when authenticating.
	* @argScope A structure containing key / value pairs of data to be included in the URL string.
	**/
	public string function buildParamString( struct argScope={} ) {
		var strURLParam = '';
		if( structCount( arguments.argScope ) ) {
			for( var key in arguments.argScope ) {
				if( listLen( strURLParam ) ) {
					strURLParam = strURLParam & '&';
				}
				strURLParam = strURLParam & lcase( key ) & '=' & trim( arguments.argScope[ key ] );
			}
			strURLParam = '?' & strURLParam;
		}
		return strURLParam;	
	}

	/**
	* I accept the structure of arguments and remove any empty / nulls values before they are sent to the OAuth processing.
	* @paramStructure I am a structure containing the arguments / parameters you wish to filter.
	*/
	public function clearEmptyParams(
		required struct paramStructure
	){
		var sParams = arguments.paramStructure;
		var sRevised = {};
		for( var param in sParams ){
			if( len( sParams[ param ] ) ){
				structInsert( sRevised, param, sParams[ param ] );
			}
		}
		return sRevised;
	}

	/**
	* Returns the properties as a struct
	*/
	public struct function getMemento(){
		var result = {};
		for( var thisProp in getMetaData( this ).properties ){
			if( structKeyExists( variables, thisProp[ 'name' ] ) ){
				result[ thisProp[ 'name' ] ] = variables[ thisProp[ 'name' ] ];
			}
		}
		return result;
	}

}