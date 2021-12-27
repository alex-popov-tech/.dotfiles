<?php
/**
 * Invoices class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for invoices endpoint.
 *
 * @link https://help.getharvest.com/api-v2/invoices-api/invoices/invoices/
 */
class Invoices extends AbstractApi {

	/**
	 * Retrieves a list of invoices.
	 *
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of invoices. Default empty array.
	 *
	 *     @type int              $client_id     Only return invoices belonging to the client with the given ID.
	 *     @type \DateTime|string $updated_since Only return invoices that have been updated since the given
	 *                                           date and time.
	 *     @type \DateTime|string $from          Only return invoices with a `issue_date` on or after the given date.
	 *     @type \DateTime|string $to            Only return invoices with a `issue_date` on or after the given date.
	 *     @type string           $state         Only return invoices with a `state` matching the value provided.
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

		$result = $this->get( '/invoices', $parameters );
		if ( ! isset( $result['invoices'] ) || ! is_array( $result['invoices'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['invoices'];
	}

	/**
	 * Retrieves the invoice with the given ID.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function show( int $invoiceId ) {
		return $this->get( '/invoices/' . rawurlencode( $invoiceId ) );
	}

	/**
	 * Creates a new invoice object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new invoice object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['client_id'] ) ) {
			throw new MissingArgumentException( 'project_id' );
		}

		if ( ! is_int( $parameters['client_id'] ) || empty( $parameters['client_id'] ) ) {
			throw new InvalidArgumentException( 'The "client_id" parameter must be a non-empty integer.' );
		}

		return $this->post( '/invoices', $parameters );
	}

	/**
	 * Updates the specific invoice by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * TODO: Consider creating an interface for managing invoice line items, see https://help.getharvest.com/api-v2/invoices-api/invoices/invoices/#create-an-invoice-line-item
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $invoiceId, array $parameters ) {
		return $this->patch( '/invoices/' . rawurlencode( $invoiceId ), $parameters );
	}

	/**
	 * Deletes an invoice.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function remove( int $invoiceId ) {
		return $this->delete( '/invoices/' . rawurlencode( $invoiceId ) );
	}

	/**
	 * Marks a draft invoice as sent.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function send( int $invoiceId ) {
		$parameters = [
			'event_type' => 'send',
		];

		return $this->post( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
	}

	/**
	 * Marks an open invoice as closed.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function close( int $invoiceId ) {
		$parameters = [
			'event_type' => 'close',
		];

		return $this->post( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
	}

	/**
	 * Re-opens a closed invoice.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function reopen( int $invoiceId ) {
		$parameters = [
			'event_type' => 're-open',
		];

		return $this->post( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
	}


	/**
	 * Marks an open invoice as a draft.
	 *
	 * @param int $invoiceId The ID of the invoice.
	 * @return array|string
	 */
	public function draft( int $invoiceId ) {
		$parameters = [
			'event_type' => 'draft',
		];

		return $this->post( '/invoices/' . rawurlencode( $invoiceId ) . '/messages', $parameters );
	}
}
