<?php
/**
 * UserAssignments class.
 */

namespace Required\Harvest\Api\Project;

use DateTime;
use Required\Harvest\Api\AbstractApi;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for project user assignments endpoint.
 *
 * @link https://help.getharvest.com/api-v2/projects-api/projects/user-assignments/
 */
class UserAssignments extends AbstractApi {

	/**
	 * Retrieves a list of user assignments for a specific project.
	 *
	 * @param int   $projectId  The ID of the project.
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of user assignments. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active user assignments and `false` to
	 *                                           return  inactive user assignments.
	 *     @type \DateTime|string $updated_since Only return user assignments that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( int $projectId, array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		if ( isset( $parameters['is_active'] ) ) {
			$parameters['is_active'] = filter_var( $parameters['is_active'], FILTER_VALIDATE_BOOLEAN ) ? 'true' : 'false';
		}

		$result = $this->get( '/projects/' . rawurlencode( $projectId ) . '/user_assignments', $parameters );
		if ( ! isset( $result['user_assignments'] ) || ! is_array( $result['user_assignments'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['user_assignments'];
	}

	/**
	 * Retrieves the user assignment with the given ID.
	 *
	 * @param int $projectId        The ID of the project.
	 * @param int $userAssignmentId The ID of the user assignment.
	 * @return array|string
	 */
	public function show( int $projectId, int $userAssignmentId ) {
		return $this->get( '/projects/' . rawurlencode( $projectId ) . '/user_assignments/' . rawurlencode( $userAssignmentId ) );
	}

	/**
	 * Creates a new user assignment object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param int   $projectId  The ID of the project.
	 * @param array $parameters The parameters of the new user assignment object.
	 * @return array|string
	 */
	public function create( int $projectId, array $parameters ) {
		if ( ! isset( $parameters['user_id'] ) ) {
			throw new MissingArgumentException( 'user_id' );
		}

		if ( ! is_int( $parameters['user_id'] ) || empty( $parameters['user_id'] ) ) {
			throw new InvalidArgumentException( 'The "user_id" parameter must be a non-empty integer.' );
		}

		return $this->post( '/projects/' . rawurlencode( $projectId ) . '/user_assignments', $parameters );
	}

	/**
	 * Updates the specific user assignment by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $projectId        The ID of the project.
	 * @param int $userAssignmentId The ID of the user assignment.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $projectId, int $userAssignmentId, array $parameters ) {
		return $this->patch( '/projects/' . rawurlencode( $projectId ) . '/user_assignments/' . rawurlencode( $userAssignmentId ), $parameters );
	}

	/**
	 * Deletes a user assignment.
	 *
	 * Deleting a user assignment is only possible if it has no time entries or expenses associated with it.
	 *
	 * @param int $projectId        The ID of the project.
	 * @param int $userAssignmentId The ID of the user assignment.
	 * @return array|string
	 */
	public function remove( int $projectId, int $userAssignmentId ) {
		return $this->delete( '/projects/' . rawurlencode( $projectId ) . '/user_assignments/' . rawurlencode( $userAssignmentId ) );
	}
}
