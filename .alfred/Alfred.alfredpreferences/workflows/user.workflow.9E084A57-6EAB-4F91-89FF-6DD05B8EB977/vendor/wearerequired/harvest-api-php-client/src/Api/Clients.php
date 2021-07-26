<?php
/**
 * Clients class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for clients endpoint.
 *
 * @link https://help.getharvest.com/api-v2/clients-api/clients/clients/
 */
class Clients extends AbstractApi {

	/**
	 * Retrieves a list of clients.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of clients. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active clients and `false` to return
	 *                                           inactive clients.
	 *     @type \DateTime|string $updated_since Only return clients that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		if ( isset( $parameters['is_active'] ) ) {
			$parameters['is_active'] = filter_var( $parameters['is_active'], FILTER_VALIDATE_BOOLEAN ) ? 'true' : 'false';
		}

		$result = $this->get( '/clients', $parameters );
		if ( ! isset( $result['clients'] ) || ! is_array( $result['clients'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['clients'];
	}

	/**
	 * Retrieves the client with the given ID.
	 *
	 * @param int $clientId The ID of the client.
	 * @return array|string
	 */
	public function show( int $clientId ) {
		return $this->get( '/clients/' . rawurlencode( $clientId ) );
	}

	/**
	 * Creates a new client object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new client object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		return $this->post( '/clients', $parameters );
	}

	/**
	 * Updates the specific client by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $clientId The ID of the client.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $clientId, array $parameters ) {
		return $this->patch( '/clients/' . rawurlencode( $clientId ), $parameters );
	}

	/**
	 * Deletes a client.
	 *
	 * Deleting a client is only possible if it has no projects, invoices, or estimates associated with it.
	 *
	 * @param int $clientId The ID of the client.
	 * @return array|string
	 */
	public function remove( int $clientId ) {
		return $this->delete( '/clients/' . rawurlencode( $clientId ) );
	}
}
