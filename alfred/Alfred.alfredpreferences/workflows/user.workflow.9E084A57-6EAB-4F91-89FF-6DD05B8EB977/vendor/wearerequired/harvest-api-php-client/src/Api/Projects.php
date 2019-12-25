<?php
/**
 * Projects class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for projects endpoint.
 *
 * @link https://help.getharvest.com/api-v2/projects-api/projects/projects/
 */
class Projects extends AbstractApi {

	/**
	 * Retrieves a list of projects.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of projects. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active projects and `false` to return
	 *                                           inactive projects.
	 *     @type int              $client_id     Only return projects belonging to the client with the given ID.
	 *     @type \DateTime|string $updated_since Only return projects that have been updated since the given
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

		$result = $this->get( '/projects', $parameters );
		if ( ! isset( $result['projects'] ) || ! is_array( $result['projects'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['projects'];
	}

	/**
	 * Retrieves the project with the given ID.
	 *
	 * @param int $projectId The ID of the project.
	 * @return array|string
	 */
	public function show( int $projectId ) {
		return $this->get( '/projects/' . rawurlencode( $projectId ) );
	}

	/**
	 * Creates a new project object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new project object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['client_id'] ) ) {
			throw new MissingArgumentException( 'client_id' );
		}

		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! isset( $parameters['is_billable'] ) ) {
			throw new MissingArgumentException( 'is_billable' );
		}

		if ( ! isset( $parameters['bill_by'] ) ) {
			throw new MissingArgumentException( 'bill_by' );
		}

		if ( ! isset( $parameters['budget_by'] ) ) {
			throw new MissingArgumentException( 'bill_by' );
		}

		if ( ! is_int( $parameters['client_id'] ) || empty( $parameters['client_id'] ) ) {
			throw new InvalidArgumentException( 'The "client_id" parameter must be a non-empty integer.' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		if ( ! is_bool( $parameters['is_billable'] ) ) {
			throw new InvalidArgumentException( 'The "is_billable" parameter must be a boolean.' );
		}

		$bill_by_options = [ 'Project', 'Tasks', 'People', 'None' ];
		if ( ! is_string( $parameters['bill_by'] ) || ! in_array( $parameters['bill_by'], $bill_by_options, true ) ) {
			throw new InvalidArgumentException(
				sprintf(
					'The "bill_by" parameter must be one out of: %s.',
					implode( ', ', $bill_by_options )
				)
			);
		}

		$budget_by_options = [ 'project', 'project_cost', 'task', 'task_fees', 'person', 'none' ];
		if ( ! is_string( $parameters['budget_by'] ) || ! in_array( $parameters['budget_by'], $budget_by_options, true ) ) {
			throw new InvalidArgumentException(
				sprintf(
					'The "budget_by" parameter must be one out of: %s.',
					implode( ', ', $budget_by_options )
				)
			);
		}

		return $this->post( '/projects', $parameters );
	}

	/**
	 * Updates the specific project by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $projectId The ID of the project.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $projectId, array $parameters ) {
		return $this->patch( '/projects/' . rawurlencode( $projectId ), $parameters );
	}

	/**
	 * Deletes a project.
	 *
	 * Deletes a project and any time entries or expenses tracked to it. However, invoices associated with the project
	 * will not be deleted. If you don’t want the project’s time entries and expenses to be deleted, you should archive
	 * the project instead:
	 *
	 *     $client->projects()->update( $projectId, [ 'is_active' => false ];
	 *
	 * @param int $projectId The ID of the project.
	 * @return array|string
	 */
	public function remove( int $projectId ) {
		return $this->delete( '/projects/' . rawurlencode( $projectId ) );
	}

	/**
	 * Gets a projects's user assignments.
	 *
	 * @return \Required\Harvest\Api\Project\UserAssignments;
	 */
	public function userAssignments() {
		return new Project\UserAssignments( $this->client );
	}

	/**
	 * Gets a projects's task assignments.
	 *
	 * @return \Required\Harvest\Api\Project\TaskAssignments;
	 */
	public function taskAssignments() {
		return new Project\TaskAssignments( $this->client );
	}
}
