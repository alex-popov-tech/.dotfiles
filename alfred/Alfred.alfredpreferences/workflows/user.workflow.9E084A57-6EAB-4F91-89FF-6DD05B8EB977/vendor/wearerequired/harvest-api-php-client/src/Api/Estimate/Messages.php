<?php
/**
 * Messages class.
 */

namespace Required\Harvest\Api\Estimate;

use DateTime;
use Required\Harvest\Api\AbstractApi;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for estimate messages endpoint.
 *
 * @link https://help.getharvest.com/api-v2/estimates-api/estimates/estimate-messages/
 */
class Messages extends AbstractApi {

	/**
	 * Retrieves a list of estimate messages for a specific estimate.
	 *
	 * @param int   $estimateId  The ID of the estimate.
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of estimate messages. Default empty array.
	 *
	 *     @type \DateTime|string $updated_since Only return estimate messages that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( int $estimateId, array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		$result = $this->get( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
		if ( ! isset( $result['messages'] ) || ! is_array( $result['messages'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['messages'];
	}

	/**
	 * Retrieves the estimate message with the given ID.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @param int $messageId  The ID of the estimate message.
	 * @return array|string
	 */
	public function show( int $estimateId, int $messageId ) {
		return $this->get( '/estimates/' . rawurlencode( $estimateId ) . '/messages/' . rawurlencode( $messageId ) );
	}

	/**
	 * Creates a new estimate message object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param int   $estimateId The ID of the estimate.
	 * @param array $parameters The parameters of the new estimate message object.
	 * @return array|string
	 */
	public function create( int $estimateId, array $parameters ) {
		if ( ! isset( $parameters['recipients'] ) ) {
			throw new MissingArgumentException( 'task_id' );
		}

		if ( ! is_array( $parameters['recipients'] ) || empty( $parameters['recipients'] ) ) {
			throw new InvalidArgumentException( 'The "recipients" parameter must be an array of recipient parameters ("name" and "email").' );
		}

		foreach ( $parameters['recipients'] as $recipient ) {
			if ( empty( $recipient['name'] ) || empty( $recipient['email'] ) ) {
				throw new InvalidArgumentException( 'The "recipients" parameter must be an array of recipient parameters ("name" and "email").' );
			}
		}

		return $this->post( '/estimates/' . rawurlencode( $estimateId ) . '/messages', $parameters );
	}

	/**
	 * Deletes an estimate message.
	 *
	 * @param int $estimateId The ID of the estimate.
	 * @param int $messageId  The ID of the estimate message.
	 * @return array|string
	 */
	public function remove( int $estimateId, int $messageId ) {
		return $this->delete( '/estimates/' . rawurlencode( $estimateId ) . '/messages/' . rawurlencode( $messageId ) );
	}
}
