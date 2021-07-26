<?php
/**
 * Messages class.
 */

namespace Required\Harvest\Api\Invoice;

use DateTime;
use Required\Harvest\Api\AbstractApi;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for invoice messages endpoint.
 *
 * @link https://help.getharvest.com/api-v2/invoices-api/invoices/invoice-messages/
 */
class Messages extends AbstractApi {

	/**
	 * Retrieves a list of invoice messages for a specific invoice.
	 *
	 * @param int   $invoiceId  The ID of the invoice.
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of invoice messages. Default empty array.
	 *
	 *     @type \DateTime|string $updated_since Only return invoice messages that have been updated since the given
	 *                                           date and time.
	 * }
	 * @return array|string
	 */
	public function all( int $invoiceId, array $parameters = [] ) {
		if ( isset( $parameters['updated_since'] ) && $parameters['updated_since'] instanceof DateTime ) {
			$parameters['updated_since'] = $parameters['updated_since']->format( 'Y-m-d H:i' );
		}

		$result = $this->get( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
		if ( ! isset( $result['messages'] ) || ! is_array( $result['messages'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['messages'];
	}

	/**
	 * Retrieves the invoice message with the given ID.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @param int $messageId  The ID of the invoice message.
	 * @return array|string
	 */
	public function show( int $invoiceId, int $messageId ) {
		return $this->get( '/invoices/' . rawurlencode( $invoiceId ) . '/messages/' . rawurlencode( $messageId ) );
	}

	/**
	 * Creates a new invoice message object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param int   $invoiceId The ID of the invoice.
	 * @param array $parameters The parameters of the new invoice message object.
	 * @return array|string
	 */
	public function create( int $invoiceId, array $parameters ) {
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

		return $this->post( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
	}

	/**
	 * Deletes an invoice message.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @param int $messageId  The ID of the invoice message.
	 * @return array|string
	 */
	public function remove( int $invoiceId, int $messageId ) {
		return $this->delete( '/invoices/' . rawurlencode( $invoiceId ) . '/messages/' . rawurlencode( $messageId ) );
	}
}
