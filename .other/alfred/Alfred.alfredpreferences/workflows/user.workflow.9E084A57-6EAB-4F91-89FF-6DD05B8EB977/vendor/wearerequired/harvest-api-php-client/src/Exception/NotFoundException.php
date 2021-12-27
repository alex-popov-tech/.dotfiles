<?php
/**
 * NotFoundException class.
 */
namespace Required\Harvest\Exception;

/**
 * Exception thrown if a requested resource doesn't exist.
 */
class NotFoundException extends RuntimeException {

	/**
	 * Constructor.
	 */
	public function __construct() {
		parent::__construct( 'The resource you requested can’t be found.' );
	}
}
