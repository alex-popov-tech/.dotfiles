<?php
/**
 * ResponseMediator class.
 */

namespace Required\Harvest\HttpClient\Message;

use Psr\Http\Message\ResponseInterface;

/**
 * Mediator for API responses.
 */
class ResponseMediator {

	/**
	 * Gets the body of the API response and decodes based on the content type.
	 *
	 * @param \Psr\Http\Message\ResponseInterface $response The API response.
	 * @return array|string
	 */
	public static function getContent( ResponseInterface $response ) {
		$body = $response->getBody()->__toString();

		if ( 0 === strpos( $response->getHeaderLine( 'Content-Type' ), 'application/json' ) ) {
			$content = json_decode( $body, true );

			if ( JSON_ERROR_NONE === json_last_error() ) {
				return $content;
			}
		}

		return $body;
	}

	/**
	 * Gets the pagination parameters of the response.
	 *
	 * @link https://help.getharvest.com/api-v2/introduction/overview/pagination/
	 *
	 * @param \Psr\Http\Message\ResponseInterface $response The API response.
	 * @return array
	 */
	public static function getPagination( ResponseInterface $response ): array {
		$content = self::getContent( $response );
		if ( ! is_array( $content ) ) {
			return [];
		}

		return [
			'page'          => $content['page'] ?? null,
			'total_pages'   => $content['total_pages'] ?? null,
			'total_entries' => $content['total_entries'] ?? null,
			'next_page'     => $content['next_page'] ?? null,
			'previous_page' => $content['previous_page'] ?? null,
		];
	}
}
