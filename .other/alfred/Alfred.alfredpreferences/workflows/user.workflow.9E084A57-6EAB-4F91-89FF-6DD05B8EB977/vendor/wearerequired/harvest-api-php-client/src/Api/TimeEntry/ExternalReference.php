<?php
/**
 * ExternalReference class.
 */

namespace Required\Harvest\Api\TimeEntry;

use Required\Harvest\Api\AbstractApi;

/**
 * API client for external reference of a time entry endpoint.
 *
 * @link https://help.getharvest.com/api-v2/timesheets-api/timesheets/time-entries/
 */
class ExternalReference extends AbstractApi {

	/**
	 * Deletes a time entry’s external reference.
	 *
	 * @param int $timeEntryId The ID of the time entry.
	 * @return array|string
	 */
	public function remove( int $timeEntryId ) {
		return $this->delete( '/time_entries/' . rawurlencode( $timeEntryId ) . '/external_reference' );
	}
}
