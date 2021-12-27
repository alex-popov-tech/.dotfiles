<?php
/**
 * AbstractApi class.
 */

namespace Required\Harvest\Api;

use Psr\Http\Message\ResponseInterface;
use Required\Harvest\Client;
use Required\Harvest\Exception\BadMethodCallException;
use Required\Harvest\HttpClient\Message\ResponseMediator;

/**
 * Abstract class for Api classes.
 */
abstract class AbstractApi implements ApiInterface {

	/**
	 * The client.
	 *
	 * @var \Required\Harvest\Client
	 */
	protected $client;

	/**
	 * @var \Required\Harvest\Api\Pagination
	 */
	protected $pagination;

	/**
	 * Constructor.
	 *
	 * @param \Required\Harvest\Client $client
	 */
	public function __construct( Client $client ) {
		$this->client     = $client;
		$this->pagination = new Pagination();
	}

	/**
	 * Retrieves requested page number.
	 *
	 * @return null|int
	 */
	public function getPage(): ?int {
		return $this->pagination->getPage();
	}

	/**
	 * Retrieves next available page number.
	 *
	 * @return null|int
	 */
	public function getNextPage(): ?int {
		return $this->pagination->getNextPage();
	}

	/**
	 * Retrieves previous available page number.
	 *
	 * @return null|int
	 */
	public function getPreviousPage(): ?int {
		return $this->pagination->getPreviousPage();
	}

	/**
	 * Sets requested page number.
	 *
	 * @param null|int $page The requested page.
	 * @return \Required\Harvest\Api\AbstractApi The current API instance
	 */
	public function setPage( $page ): AbstractApi {
		$this->pagination->setPage( $page );

		return $this;
	}

	/**
	 * Retrieves number of items per page.
	 *
	 * @return null|int
	 */
	public function getPerPage(): ?int {
		return $this->pagination->getPerPage();
	}

	/**
	 * Sets number of items per page.
	 *
	 * @param null|int $perPage Number of items per page.
	 * @return \Required\Harvest\Api\AbstractApi The current API instance
	 */
	public function setPerPage( $perPage ): AbstractApi {
		$this->pagination->setPerPage( $perPage );

		return $this;
	}

	/**
	 * Resets pagination.
	 *
	 * @return \Required\Harvest\Api\AbstractApi The current API instance
	 */
	public function resetPagination() {
		$this->pagination->reset();

		return $this;
	}

	/**
	 * Whether the current request has a next page.
	 *
	 * @return bool True if next page exists, false if not.
	 */
	public function hasMore(): bool {
		return $this->pagination->hasMore();
	}

	/**
	 * Retrieves a list of items with automatic pagination.
	 *
	 * @param array $parameters Optional. Parameters for filtering the list of items. Default empty array.
	 * @return \Required\Harvest\Api\AutoPagingIterator The iterator.
	 */
	public function allWithAutoPagingIterator( array $parameters = [] ): AutoPagingIterator {
		if ( ! method_exists( static::class, 'all' ) ) {
			throw new BadMethodCallException( 'The resource does not support retrieving all objects.' );
		}

		return new AutoPagingIterator( $this, $parameters );
	}

	/**
	 * Sends a GET request with query parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     GET parameters.
	 * @param array  $requestHeaders Request Headers.
	 * @return array|string
	 */
	protected function get( $path, array $parameters = [], array $requestHeaders = [] ) {
		$page = $this->pagination->getPage();
		if ( null !== $page && ! isset( $parameters['page'] ) ) {
			$parameters['page'] = $page;
		}
		$perPage = $this->pagination->getPerPage();
		if ( null !== $perPage && ! isset( $parameters['per_page'] ) ) {
			$parameters['per_page'] = $perPage;
		}

		if ( count( $parameters ) > 0 ) {
			$path .= '?' . http_build_query( $parameters );
		}

		$response = $this->client->getHttpClient()->get( $path, $requestHeaders );

		$pagination = ResponseMediator::getPagination( $response );
		if ( $pagination ) {
			$this->pagination->setTotalEntries( $pagination['total_entries'] );
			$this->pagination->setTotalPages( $pagination['total_pages'] );
			$this->pagination->setNextPage( $pagination['next_page'] );
			$this->pagination->setPreviousPage( $pagination['previous_page'] );
		}

		return ResponseMediator::getContent( $response );
	}

	/**
	 * Sends a HEAD request with query parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     HEAD parameters.
	 * @param array  $requestHeaders Request headers.
	 * @return \Psr\Http\Message\ResponseInterface
	 */
	protected function head( $path, array $parameters = [], array $requestHeaders = [] ): ResponseInterface {
		$response = $this->client->getHttpClient()->head(
			$path . '?' . http_build_query( $parameters ),
			$requestHeaders
		);

		return $response;
	}

	/**
	 * Sends a POST request with JSON-encoded parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     POST parameters to be JSON encoded.
	 * @param array  $requestHeaders Request headers.
	 * @return array|string
	 */
	protected function post( $path, array $parameters = [], array $requestHeaders = [] ) {
		$requestHeaders = array_merge( [ 'Content-Type' => 'application/json' ], $requestHeaders );

		$response = $this->client->getHttpClient()->post(
			$path,
			$requestHeaders,
			$this->createJsonBody( $parameters )
		);

		return ResponseMediator::getContent( $response );
	}

	/**
	 * Sends a PATCH request with JSON-encoded parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     POST parameters to be JSON encoded.
	 * @param array  $requestHeaders Request headers.
	 * @return array|string
	 */
	protected function patch( $path, array $parameters = [], array $requestHeaders = [] ) {
		$requestHeaders = array_merge( [ 'Content-Type' => 'application/json' ], $requestHeaders );

		$response = $this->client->getHttpClient()->patch(
			$path,
			$requestHeaders,
			$this->createJsonBody( $parameters )
		);

		return ResponseMediator::getContent( $response );
	}

	/**
	 * Sends a PUT request with JSON-encoded parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     POST parameters to be JSON encoded.
	 * @param array  $requestHeaders Request headers.
	 * @return array|string
	 */
	protected function put( $path, array $parameters = [], array $requestHeaders = [] ) {
		$requestHeaders = array_merge( [ 'Content-Type' => 'application/json' ], $requestHeaders );

		$response = $this->client->getHttpClient()->put(
			$path,
			$requestHeaders,
			$this->createJsonBody( $parameters )
		);

		return ResponseMediator::getContent( $response );
	}

	/**
	 * Sends a DELETE request with JSON-encoded parameters.
	 *
	 * @param string $path           Request path.
	 * @param array  $parameters     POST parameters to be JSON encoded.
	 * @param array  $requestHeaders Request headers.
	 * @return array|string
	 */
	protected function delete( $path, array $parameters = [], array $requestHeaders = [] ) {
		$requestHeaders = array_merge( [ 'Content-Type' => 'application/json' ], $requestHeaders );

		$response = $this->client->getHttpClient()->delete(
			$path,
			$requestHeaders,
			$this->createJsonBody( $parameters )
		);

		return ResponseMediator::getContent( $response );
	}

	/**
	 * Creates a JSON encoded version of an array of parameters.
	 *
	 * @param array $parameters Request parameters
	 * @return null|string
	 */
	protected function createJsonBody( array $parameters ): ?string {
		return ( count( $parameters ) === 0 ) ? null : json_encode( $parameters, empty( $parameters ) ? JSON_FORCE_OBJECT : 0 );
	}
}
