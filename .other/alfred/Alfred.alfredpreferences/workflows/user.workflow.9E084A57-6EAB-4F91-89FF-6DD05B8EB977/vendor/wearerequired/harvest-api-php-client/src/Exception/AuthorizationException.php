<?php
/**
 * AuthorizationException class.
 */
namespace Required\Harvest\Exception;

/**
 * Exception thrown if a user do not have authorization to perform a request.
 */
class AuthorizationException extends RuntimeException {

	/**
	 * Constructor.
	 */
	public function __construct() {
		parent::__construct( 'The resource you requested was found but you don’t have authorization to perform your request.' );
	}
}
