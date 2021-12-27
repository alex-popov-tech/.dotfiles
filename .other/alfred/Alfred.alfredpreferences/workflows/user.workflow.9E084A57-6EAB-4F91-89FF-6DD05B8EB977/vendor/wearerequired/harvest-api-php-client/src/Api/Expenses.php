<?php
/**
 * Expenses class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for expenses endpoint.
 *
 * @link https://help.getharvest.com/api-v2/expenses-api/expenses/expenses/
 */
class Expenses extends AbstractApi {

	/**
	 * Retrieves a list of expenses.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of expenses. Default empty array.
	 *
	 *     @type int              $user_id       Only return expenses belonging to the user with the given ID.
	 *     @type int              $client_id     Only return expenses belonging to the client with the given ID.
	 *     @type int              $project_id    Only return expenses belonging to the project with the given ID.
	 *     @type bool             $is_billed     Pass `true` to only return expenses that have been invoiced and
	 *                                           `false` to return expenses that have not been invoiced.
	 *     @type \DateTime|string $updated_since Only return expenses that have been updated since the given
	 *                                           date and time.
	 *     @type \DateTime|string $from          Only return expenses with a `spent_date` on or after the given date.
	 *     @type \DateTime|string $to            Only return expenses with a `spent_date` on or after the given date.
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

		if ( isset( $parameters['is_billed'] ) ) {
			$parameters['is_billed'] = filter_var( $parameters['is_billed'], FILTER_VALIDATE_BOOLEAN ) ? 'true' : 'false';
		}

		$result = $this->get( '/expenses', $parameters );
		if ( ! isset( $result['expenses'] ) || ! is_array( $result['expenses'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['expenses'];
	}

	/**
	 * Retrieves the expense with the given ID.
	 *
	 * @param int $expenseId The ID of the expense.
	 * @return array|string
	 */
	public function show( int $expenseId ) {
		return $this->get( '/expenses/' . rawurlencode( $expenseId ) );
	}

	/**
	 * Creates a new expense object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new expense object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['project_id'] ) ) {
			throw new MissingArgumentException( 'project_id' );
		}

		if ( ! isset( $parameters['expense_category_id'] ) ) {
			throw new MissingArgumentException( 'expense_category_id' );
		}

		if ( ! isset( $parameters['spent_date'] ) ) {
			throw new MissingArgumentException( 'spent_date' );
		}

		if ( ! is_int( $parameters['project_id'] ) || empty( $parameters['project_id'] ) ) {
			throw new InvalidArgumentException( 'The "project_id" parameter must be a non-empty integer.' );
		}

		if ( ! is_int( $parameters['expense_category_id'] ) || empty( $parameters['expense_category_id'] ) ) {
			throw new InvalidArgumentException( 'The "expense_category_id" parameter must be a non-empty integer.' );
		}

		if ( ! is_string( $parameters['spent_date'] ) || $parameters['spent_date'] instanceof DateTime ) {
			throw new InvalidArgumentException( 'The "spent_date" parameter must be DateTime instance or an ISO 8601 formatted date string.' );
		}

		return $this->post( '/expenses', $parameters );
	}

	/**
	 * Updates the specific expense by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $expenseId The ID of the expense.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $expenseId, array $parameters ) {
		return $this->patch( '/expenses/' . rawurlencode( $expenseId ), $parameters );
	}

	/**
	 * Deletes an expense.
	 *
	 * @param int $expenseId The ID of the expense.
	 * @return array|string
	 */
	public function remove( int $expenseId ) {
		return $this->delete( '/expenses/' . rawurlencode( $expenseId ) );
	}
}
