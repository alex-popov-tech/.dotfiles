<?php
/**
 * ResponseExceptionThrower class.
 */

namespace Required\Harvest\HttpClient\Plugin;

use Http\Client\Common\Plugin;
use Http\Promise\Promise;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;
use Required\Harvest\Exception\AuthorizationException;
use Required\Harvest\Exception\HarvestApiRateLimitExceedException;
use Required\Harvest\Exception\AuthenticationException;
use Required\Harvest\Exception\NotFoundException;
use Required\Harvest\Exception\RuntimeException;
use Required\Harvest\Exception\ValidationFailedException;
use Required\Harvest\HttpClient\Message\ResponseMediator;

/**
 * A plugin to throw exceptions on response errors.
 */
class ResponseExceptionThrower implements Plugin {

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
		return $next( $request )->then(
			function ( ResponseInterface $response ) {
				$statusCode = $response->getStatusCode();

				if ( $statusCode < 400 || $statusCode > 600 ) {
					return $response;
				}

				if ( 429 === $statusCode ) {
					throw new HarvestApiRateLimitExceedException();
				}

				$content = ResponseMediator::getContent( $response );

				if ( 401 === $statusCode ) {
					throw new AuthenticationException( $content['error_description'] ?? $content );
				}

				if ( 403 === $statusCode ) {
					throw new AuthorizationException();
				}

				if ( 404 === $statusCode ) {
					throw new NotFoundException();
				}

				if ( 422 === $statusCode ) {
					throw new ValidationFailedException( $content['message'] ?? json_encode( $content ), $statusCode );
				}

				throw new RuntimeException( $content['message'] ?? json_encode( $content ), $statusCode );
			}
		);
	}
}
