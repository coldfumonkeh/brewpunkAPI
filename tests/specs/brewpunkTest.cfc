component extends='testbox.system.BaseSpec'{
	
	/*********************************** BDD SUITES ***********************************/
	
	function run(){

		describe( 'Brew Punk API Component Suite', function(){

			var oBrewpunk = new brewpunk();
			
			it( 'should return the correct object', function(){

				expect( oBrewpunk ).toBeInstanceOf( 'brewpunk' );
				expect( oBrewpunk ).toBeTypeOf( 'component' );

				expect( oBrewpunk ).toHavekey( 'init' );
				expect( oBrewpunk ).toHavekey( 'getBeers' );
				expect( oBrewpunk ).toHavekey( 'getBeer' );
				expect( oBrewpunk ).toHavekey( 'getRandomBeer' );
				expect( oBrewpunk ).toHavekey( 'makeRequest' );
				expect( oBrewpunk ).toHavekey( 'buildParamString' );
				expect( oBrewpunk ).toHavekey( 'clearEmptyParams' );
				expect( oBrewpunk ).toHavekey( 'getMemento' );

				var sMemento = oBrewpunk.getMemento();
				expect( sMemento ).toBeStruct().toHaveLength( 3 );
				expect( sMemento ).toHaveKey( 'endpoint' );
				expect( sMemento ).toHaveKey( 'rateLimit' );
				expect( sMemento ).toHaveKey( 'rateLimitRemaining' );

			});


			it( 'should return all beers', function() {

				var result = oBrewpunk.getBeers();

				expect( result ).toBeStruct();
				expect( result ).toHaveKey( 'success' );
				expect( result ).toHaveKey( 'content' );
				expect( result[ 'content' ] ).toBeString();


				var result = oBrewpunk.getBeers( 'parseResponse' = true );

				expect( result[ 'content' ] ).toBeArray();

				expect( oBrewpunk.getRateLimit() ).toBeGT( oBrewpunk.getRateLimitRemaining() );

			} );

			it( 'should return all beers with additional parameters', function() {

				var sParams = {
					'abv_gt': '3',
					'abv_lt': '20'
				};

				var result = oBrewpunk.getBeers(
					argumentCollection = sParams
				);

				expect( oBrewpunk.getRateLimit() ).toBeGT( oBrewpunk.getRateLimitRemaining() );

			} );

			it( 'should return a specific beer', function() {

				var result = oBrewpunk.getBeer(
					beerID        = 1,
					parseResponse = true
				);

				expect( result[ 'content' ] ).toBeArray();
				expect( result[ 'content' ] ).toHaveLength( 1 );
				expect( result[ 'content' ][ 1 ][ 'id' ] ).toBe( 1 );

				expect( oBrewpunk.getRateLimit() ).toBeGT( oBrewpunk.getRateLimitRemaining() );

			} );

			it( 'should return a random beer', function() {

				var result = oBrewpunk.getRandomBeer(
					parseResponse = true
				);

				expect( result[ 'content' ] ).toBeArray();
				expect( result[ 'content' ] ).toHaveLength( 1 );

				expect( oBrewpunk.getRateLimit() ).toBeGT( oBrewpunk.getRateLimitRemaining() );

			} );

		});

	}
	
}
