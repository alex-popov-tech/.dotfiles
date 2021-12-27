<?php
/**
 * Tasks class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for tasks endpoint.
 *
 * @link https://help.getharvest.com/api-v2/tasks-api/tasks/tasks/
 */
class Tasks extends AbstractApi {

	/**
	 * Retrieves a list of tasks.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of tasks. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active tasks and `false` to return
	 *                                           inactive tasks.
	 *     @type \DateTime|string $updated_since Only return tasks that have been updated since the given
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

		$result = $this->get( '/tasks', $parameters );
		if ( ! isset( $result['tasks'] ) || ! is_array( $result['tasks'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['tasks'];
	}

	/**
	 * Retrieves the task with the given ID.
	 *
	 * @param int $taskId The ID of the task.
	 * @return array|string
	 */
	public function show( int $taskId ) {
		return $this->get( '/tasks/' . rawurlencode( $taskId ) );
	}

	/**
	 * Creates a new task object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new task object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		return $this->post( '/tasks', $parameters );
	}

	/**
	 * Updates the specific task by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $taskId The ID of the task.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $taskId, array $parameters ) {
		return $this->patch( '/tasks/' . rawurlencode( $taskId ), $parameters );
	}

	/**
	 * Deletes a task.
	 *
	 * Deleting a task is only possible if it has no time entries associated with it.
	 *
	 * @param int $taskId The ID of the task.
	 * @return array|string
	 */
	public function remove( int $taskId ) {
		return $this->delete( '/tasks/' . rawurlencode( $taskId ) );
	}
}
