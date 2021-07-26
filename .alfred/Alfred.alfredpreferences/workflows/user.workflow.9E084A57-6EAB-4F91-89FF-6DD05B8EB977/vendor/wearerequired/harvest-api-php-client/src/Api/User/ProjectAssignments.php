<?php
/**
 * ProjectAssignments class.
 */

namespace Required\Harvest\Api\User;

use DateTime;
use Required\Harvest\Api\AbstractApi;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for user project assignments endpoint.
 *
 * @link https://help.getharvest.com/api-v2/users-api/users/project-assignments/
 */
class ProjectAssignments extends AbstractApi {

	/**
	 * Retrieves a list of project assignments for a specific user.
	 *
	 * @param int   $userId  The ID of the project.
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of project assignments. Default empty array.
	 *
	 *     @type \DateTime|string $updated_since Only return project assignments that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( int $userId, array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		$result = $this->get( '/users/' . rawurlencode( $userId ) . '/project_assignments', $parameters );
		if ( ! isset( $result['project_assignments'] ) || ! is_array( $result['project_assignments'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['project_assignments'];
	}
}
