<?php
/**
 * UserAssignments class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for user assignments endpoint.
 *
 * @link https://help.getharvest.com/api-v2/projects-api/projects/user-assignments/
 */
class UserAssignments extends AbstractApi {

	/**
	 * Retrieves a list of user assignments.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of user assignments. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active user assignments and `false` to
	 *                                           return  inactive user assignments.
	 *     @type \DateTime|string $updated_since Only return user assignments that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array
	 */
	public function all( array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		if ( isset( $parameters['is_active'] ) ) {
			$parameters['is_active'] = filter_var( $parameters['is_active'], FILTER_VALIDATE_BOOLEAN ) ? 'true' : 'false';
		}

		$result = $this->get( '/user_assignments', $parameters );
		if ( ! isset( $result['user_assignments'] ) || ! is_array( $result['user_assignments'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['user_assignments'];
	}
}
