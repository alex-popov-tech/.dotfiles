<?php
/**
 * CurrentCompany class.
 */

namespace Required\Harvest\Api;

/**
 * API client for company endpoint.
 *
 * @link https://help.getharvest.com/api-v2/company-api/company/company/
 */
class CurrentCompany extends AbstractApi {

	/**
	 * Retrieves the company for the currently authenticated user.
	 *
	 * @return array|string
	 */
	public function show() {
		return $this->get( '/company' );
	}
}
