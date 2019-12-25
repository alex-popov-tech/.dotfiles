<?php
/**
 * MissingArgumentException class.
 */

namespace Required\Harvest\Exception;

/**
 * Exception thrown if a required parameter is missing.
 */
class MissingArgumentException extends ErrorException {

	/**
	 * Constructor.
	 *
	 * @param string $missingArgument The name of the missing argument.
	 */
	public function __construct( string $missingArgument ) {
		parent::__construct( sprintf( 'The required parameter "%s" is missing', $missingArgument ) );
	}
}
