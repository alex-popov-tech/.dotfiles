<?php
/**
 * CurrentUser class.
 */

namespace Required\Harvest\Api;

/**
 * API client for users endpoint.
 *
 * @link https://help.getharvest.com/api-v2/authentication-api/authentication/authentication/#personal-access-tokens
 */
class CurrentUser extends AbstractApi {

	/**
	 * Retrieves the authenticated user.
	 *
	 * @return array|string
	 */
	public function show() {
		return $this->get( '/users/me' );
	}

	/**
	 * Gets the authenticated user's project assignments.
	 *
	 * @return \Required\Harvest\Api\CurrentUser\ProjectAssignments;
	 */
	public function projectAssignments() {
		return new CurrentUser\ProjectAssignments( $this->client );
	}
}
