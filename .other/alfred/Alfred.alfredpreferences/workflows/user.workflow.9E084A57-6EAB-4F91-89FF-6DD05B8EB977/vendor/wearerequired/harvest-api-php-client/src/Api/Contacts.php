<?php
/**
 * Contacts class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for contacts endpoint.
 *
 * @link https://help.getharvest.com/api-v2/clients-api/clients/contacts/
 */
class Contacts extends AbstractApi {

	/**
	 * Retrieves a list of contacts.
	 *
	 * @param array $parameters {
	 *      Optional. Parameters for filtering the list of contacts. Default empty array.
	 *
	 *     @type int              $client_id     Only return contacts belonging to the client with the given ID.
	 *     @type \DateTime|string $updated_since Only return contacts that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		$result = $this->get( '/contacts', $parameters );
		if ( ! isset( $result['contacts'] ) || ! is_array( $result['contacts'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['contacts'];
	}

	/**
	 * Retrieves the contact with the given ID.
	 *
	 * @param int $contactId The ID of the contact.
	 * @return array|string
	 */
	public function show( int $contactId ) {
		return $this->get( '/contacts/' . rawurlencode( $contactId ) );
	}

	/**
	 * Creates a new contact object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new contact object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['client_id'] ) ) {
			throw new MissingArgumentException( 'client_id' );
		}

		if ( ! isset( $parameters['first_name'] ) ) {
			throw new MissingArgumentException( 'first_name' );
		}

		if ( ! is_int( $parameters['client_id'] ) || empty( $parameters['client_id'] ) ) {
			throw new InvalidArgumentException( 'The "client_id" parameter must be a non-empty integer.' );
		}

		if ( ! is_string( $parameters['first_name'] ) || empty( trim( $parameters['first_name'] ) ) ) {
			throw new InvalidArgumentException( 'The "first_name" parameter must be a non-empty string.' );
		}

		return $this->post( '/contacts', $parameters );
	}

	/**
	 * Updates the specific contact by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $contactId The ID of the contact.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $contactId, array $parameters ) {
		return $this->patch( '/contacts/' . rawurlencode( $contactId ), $parameters );
	}

	/**
	 * Deletes a contact.
	 *
	 * @param int $contactId The ID of the contact.
	 * @return array|string
	 */
	public function remove( int $contactId ) {
		return $this->delete( '/contacts/' . rawurlencode( $contactId ) );
	}
}
