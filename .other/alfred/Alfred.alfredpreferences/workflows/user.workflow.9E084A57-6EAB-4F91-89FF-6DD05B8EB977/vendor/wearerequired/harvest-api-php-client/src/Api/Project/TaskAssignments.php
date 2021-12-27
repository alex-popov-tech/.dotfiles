<?php
/**
 * TaskAssignments class.
 */

namespace Required\Harvest\Api\Project;

use DateTime;
use Required\Harvest\Api\AbstractApi;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for project task assignments endpoint.
 *
 * @link https://help.getharvest.com/api-v2/projects-api/projects/task-assignments/
 */
class TaskAssignments extends AbstractApi {

	/**
	 * Retrieves a list of task assignments for a specific project.
	 *
	 * @param int   $projectId  The ID of the project.
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of task assignments. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active task assignments and `false` to
	 *                                           return  inactive task assignments.
	 *     @type \DateTime|string $updated_since Only return task assignments that have been updated since the given
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

		$result = $this->get( '/projects/' . rawurlencode( $projectId ) . '/task_assignments', $parameters );
		if ( ! isset( $result['task_assignments'] ) || ! is_array( $result['task_assignments'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['task_assignments'];
	}

	/**
	 * Retrieves the task assignment with the given ID.
	 *
	 * @param int $projectId        The ID of the project.
	 * @param int $taskAssignmentId The ID of the task assignment.
	 * @return array|string
	 */
	public function show( int $projectId, int $taskAssignmentId ) {
		return $this->get( '/projects/' . rawurlencode( $projectId ) . '/task_assignments/' . rawurlencode( $taskAssignmentId ) );
	}

	/**
	 * Creates a new task assignment object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param int   $projectId  The ID of the project.
	 * @param array $parameters The parameters of the new task assignment object.
	 * @return array|string
	 */
	public function create( int $projectId, array $parameters ) {
		if ( ! isset( $parameters['task_id'] ) ) {
			throw new MissingArgumentException( 'task_id' );
		}

		if ( ! is_int( $parameters['task_id'] ) || empty( $parameters['task_id'] ) ) {
			throw new InvalidArgumentException( 'The "task_id" parameter must be a non-empty integer.' );
		}

		return $this->post( '/projects/' . rawurlencode( $projectId ) . '/task_assignments', $parameters );
	}

	/**
	 * Updates the specific task assignment by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int   $projectId        The ID of the project.
	 * @param int   $taskAssignmentId The ID of the task assignment.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $projectId, int $taskAssignmentId, array $parameters ) {
		return $this->patch( '/projects/' . rawurlencode( $projectId ) . '/task_assignments/' . rawurlencode( $taskAssignmentId ), $parameters );
	}

	/**
	 * Deletes a task assignment.
	 *
	 * Deleting a task assignment is only possible if it has no time entries associated with it.
	 *
	 * @param int $projectId        The ID of the project.
	 * @param int $taskAssignmentId The ID of the task assignment.
	 * @return array|string
	 */
	public function remove( int $projectId, int $taskAssignmentId ) {
		return $this->delete( '/projects/' . rawurlencode( $projectId ) . '/task_assignments/' . rawurlencode( $taskAssignmentId ) );
	}
}
