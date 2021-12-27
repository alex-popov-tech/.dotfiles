<?php
/**
 * TaskAssignments class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for task assignments endpoint.
 *
 * @link https://help.getharvest.com/api-v2/projects-api/projects/task-assignments/
 */
class TaskAssignments extends AbstractApi {

	/**
	 * Retrieves a list of task assignments.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of task assignments. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active task assignments and `false` to
	 *                                           return  inactive task assignments.
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

		$result = $this->get( '/task_assignments', $parameters );
		if ( ! isset( $result['task_assignments'] ) || ! is_array( $result['task_assignments'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['task_assignments'];
	}
}
