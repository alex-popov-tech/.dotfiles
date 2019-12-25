<?php
/**
 * HarvestApiRateLimitExceedException.
 */

namespace Required\Harvest\Exception;

/**
 * Exception thrown if the Harvest API rate limit limit has been exceeded.
 */
class HarvestApiRateLimitExceedException extends RuntimeException {

	/**
	 * Constructor.
	 */
	public function __construct() {
		parent::__construct( 'You have reached the 100 requests per 15 seconds limit. See https://help.getharvest.com/api-v2/introduction/overview/general/#rate-limiting for more.' );
	}
}
