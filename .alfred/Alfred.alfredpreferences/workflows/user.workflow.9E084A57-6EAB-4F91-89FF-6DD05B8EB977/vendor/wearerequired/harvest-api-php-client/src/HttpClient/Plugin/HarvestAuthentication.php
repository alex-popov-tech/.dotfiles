<?php
/**
 * HarvestAuthentication class.
 */

namespace Required\Harvest\HttpClient\Plugin;

use Http\Client\Common\Plugin;
use Http\Promise\Promise;
use Psr\Http\Message\RequestInterface;

/**
 * A plugin to provide Harvest authentication headers.
 *
 * @link https://help.getharvest.com/api-v2/authentication-api/authentication/authentication/
 *
 * @package Required\Harvest\HttpClient\Plugin
 */
class HarvestAuthentication implements Plugin {

	/**
	 * The Harvest account ID.
	 *
	 * @var string|null
	 */
	private $accountId;

	/**
	 * The API access token.
	 *
	 * @var string|null
	 */
	private $accessToken;

	/**
	 * Authentication constructor.
	 *
	 * @param string $accountId   The Harvest account ID.
	 * @param string $accessToken The API access token.
	 */
	public function __construct( string $accountId, string $accessToken ) {
		$this->accountId   = $accountId;
		$this->accessToken = $accessToken;
	}

	/**
	 * Handles the request and returns the response coming from the next callable.
	 *
	 * @see http://docs.php-http.org/en/latest/plugins/build-your-own.html
	 *
	 * @param \Psr\Http\Message\RequestInterface $request The request.
	 * @param callable                           $next    Next middleware in the chain, the request is passed as the
	 *                                                    first argument
	 * @param callable                           $first   First middleware in the chain, used to to restart a request
	 *
	 * @return \Http\Promise\Promise Resolves a PSR-7 Response or fails with an Http\Client\Exception (The same as
	 *                               HttpAsyncClient).
	 */
	public function handleRequest( RequestInterface $request, callable $next, callable $first ): Promise {
		$request = $request->withHeader( 'Authorization', sprintf( 'Bearer %s', $this->accessToken ) );
		$request = $request->withHeader( 'Harvest-Account-Id', $this->accountId );

		return $next( $request );
	}
}
