<?php
/**
 * Roles class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for roles endpoint.
 *
 * @link https://help.getharvest.com/api-v2/roles-api/roles/roles/
 */
class Roles extends AbstractApi {

	/**
	 * Retrieves a list of roles.
	 *
	 * @return array
	 */
	public function all() {
		$result = $this->get( '/roles' );
		if ( ! isset( $result['roles'] ) || ! is_array( $result['roles'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['roles'];
	}

	/**
	 * Retrieves the role with the given ID.
	 *
	 * @param int $roleId The ID of the role.
	 * @return array|string
	 */
	public function show( int $roleId ) {
		return $this->get( '/roles/' . rawurlencode( $roleId ) );
	}

	/**
	 * Creates a new role object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new role object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		return $this->post( '/roles', $parameters );
	}

	/**
	 * Updates the specific role by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param int $roleId The ID of the role.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $roleId, array $parameters ) {
		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		return $this->patch( '/roles/' . rawurlencode( $roleId ), $parameters );
	}

	/**
	 * Deletes a role.
	 *
	 * Deleting a role will unlink it from any users it was assigned to.
	 *
	 * @param int $roleId The ID of the role.
	 * @return array|string
	 */
	public function remove( int $roleId ) {
		return $this->delete( '/roles/' . rawurlencode( $roleId ) );
	}
}
