<?php
/**
 * Estimates class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for estimates endpoint.
 *
 * @link https://help.getharvest.com/api-v2/estimates-api/estimates/estimates/
 */
class Estimates extends AbstractApi {

	/**
	 * Retrieves a list of estimates.
	 *
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of estimates. Default empty array.
	 *
	 *     @type int              $client_id     Only return estimates belonging to the client with the given ID.
	 *     @type \DateTime|string $updated_since Only return estimates that have been updated since the given
	 *                                           date and time.
	 *     @type \DateTime|string $from          Only return estimates with a `issue_date` on or after the given date.
	 *     @type \DateTime|string $to            Only return estimates with a `issue_date` on or after the given date.
	 *     @type string           $state         Only return estimates with a `state` matching the value provided.
	 *                                           Options: 'draft', 'sent', 'accepted', or 'declined'.
	 * }
	 * @return array|string
	 */
	public function all( array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		if ( isset( $parameters['from'] ) && $parameters['from'] instanceof DateTime ) {
			$parameters['from'] = $parameters['from']->format( 'Y-m-d' );
		}

		if ( isset( $parameters['to'] ) && $parameters['to'] instanceof DateTime ) {
			$parameters['to'] = $parameters['to']->format( 'Y-m-d' );
		}

		$state_options = [ 'draft', 'sent', 'accepted', 'declined' ];
		if ( isset( $parameters['state'] ) && ! in_array( $parameters['state'], $state_options, true ) ) {
			throw new InvalidArgumentException(
				sprintf(
					'The "state" parameter must be one out of: %s.',
					implode( ', ', $state_options )
				)
			);
		}

		$result = $this->get( '/estimates', $parameters );
		if ( ! isset( $result['estimates'] ) || ! is_array( $result['estimates'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['estimates'];
	}

	/**
	 * Retrieves the estimate with the given ID.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function show( int $estimateId ) {
		return $this->get( '/estimates/' . rawurlencode( $estimateId ) );
	}

	/**
	 * Creates a new estimate object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new estimate object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['client_id'] ) ) {
			throw new MissingArgumentException( 'project_id' );
		}

		if ( ! is_int( $parameters['client_id'] ) || empty( $parameters['client_id'] ) ) {
			throw new InvalidArgumentException( 'The "client_id" parameter must be a non-empty integer.' );
		}

		return $this->post( '/estimates', $parameters );
	}

	/**
	 * Updates the specific estimate by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * TODO: Consider creating an interface for managing estimate line items, see https://help.getharvest.com/api-v2/estimates-api/estimates/estimates/#create-an-estimate-line-item
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $estimateId, array $parameters ) {
		return $this->patch( '/estimates/' . rawurlencode( $estimateId ), $parameters );
	}

	/**
	 * Deletes an estimate.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function remove( int $estimateId ) {
		return $this->delete( '/estimates/' . rawurlencode( $estimateId ) );
	}

	/**
	 * Marks a draft estimate as sent.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function send( int $estimateId ) {
		$parameters = [
			'event_type' => 'send',
		];

		return $this->post( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
	}

	/**
	 * Marks an open estimate as accepted.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function accept( int $estimateId ) {
		$parameters = [
			'event_type' => 'accept',
		];

		return $this->post( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
	}

	/**
	 * Marks an open estimate as declined.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function decline( int $estimateId ) {
		$parameters = [
			'event_type' => 'decline',
		];

		return $this->post( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
	}

	/**
	 * Re-opens a closed estimate
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @return array|string
	 */
	public function reopen( int $estimateId ) {
		$parameters = [
			'event_type' => 're-open',
		];

		return $this->post( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
	}
}
