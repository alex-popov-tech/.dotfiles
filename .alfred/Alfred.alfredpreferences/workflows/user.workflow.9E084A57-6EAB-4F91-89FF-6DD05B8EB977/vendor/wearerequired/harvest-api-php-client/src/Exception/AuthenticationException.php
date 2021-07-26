<?php
/**
 * AuthenticationException class.
 */
namespace Required\Harvest\Exception;

/**
 * Exception thrown if an authentication has failed.
 */
class AuthenticationException extends RuntimeException {

	/**
	 * Constructor.
	 *
	 * @param string $message The authentication error message.
	 */
	public function __construct( string $message = '' ) {
		parent::__construct( sprintf( 'Authentication error: %s', $message ) );
	}
}
