<?php
/**
 * ExpenseCategories class.
 */

namespace Required\Harvest\Api;

use DateTime;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\Exception\MissingArgumentException;
use Required\Harvest\Exception\RuntimeException;

/**
 * API client for expense categories endpoint.
 *
 * @link https://help.getharvest.com/api-v2/expenses-api/expenses/expense-categories/
 */
class ExpenseCategories extends AbstractApi {

	/**
	 * Retrieves a list of expense categories.
	 *
	 * @param array $parameters {
	 *     Optional. Parameters for filtering the list of expense categories. Default empty array.
	 *
	 *     @type bool             $is_active     Pass `true` to only return active expense categories and `false`
	 *                                           to return inactive expense categories.
	 *     @type int              $client_id     Only return expense categories belonging to the client with the given ID.
	 *     @type \DateTime|string $updated_since Only return expense categories that have been updated since the given
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

		$result = $this->get( '/expense_categories', $parameters );
		if ( ! isset( $result['expense_categories'] ) || ! is_array( $result['expense_categories'] ) ) {
			throw new RuntimeException( 'Unexpected result.' );
		}

		return $result['expense_categories'];
	}

	/**
	 * Retrieves the expense category with the given ID.
	 *
	 * @param int $expenseCategoryId The ID of the expense category.
	 * @return array|string
	 */
	public function show( int $expenseCategoryId ) {
		return $this->get( '/expense_categories/' . rawurlencode( $expenseCategoryId ) );
	}

	/**
	 * Creates a new expense category object.
	 *
	 * @throws \Required\Harvest\Exception\MissingArgumentException
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param array $parameters The parameters of the new expense category object.
	 * @return array|string
	 */
	public function create( array $parameters ) {
		if ( ! isset( $parameters['name'] ) ) {
			throw new MissingArgumentException( 'name' );
		}

		if ( ! is_string( $parameters['name'] ) || empty( trim( $parameters['name'] ) ) ) {
			throw new InvalidArgumentException( 'The "name" parameter must be a non-empty string.' );
		}

		return $this->post( '/expense_categories', $parameters );
	}

	/**
	 * Updates the specific expense category by setting the values of the parameters passed.
	 *
	 * Any parameters not provided will be left unchanged.
	 *
	 * @param int $expenseCategoryId The ID of the expense category.
	 * @param array $parameters
	 * @return array|string
	 */
	public function update( int $expenseCategoryId, array $parameters ) {
		return $this->patch( '/expense_categories/' . rawurlencode( $expenseCategoryId ), $parameters );
	}

	/**
	 * Deletes an expense category.
	 *
	 * @param int $expenseCategoryId The ID of the expense category.
	 * @return array|string
	 */
	public function remove( int $expenseCategoryId ) {
		return $this->delete( '/expense_categories/' . rawurlencode( $expenseCategoryId ) );
	}
}
