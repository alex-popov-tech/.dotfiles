<?php
/**
 * Client class.
 */

namespace Required\Harvest;

use Http\Client\Common\HttpMethodsClient;
use Http\Client\Common\Plugin;
use Http\Client\HttpClient;
use Http\Discovery\UriFactoryDiscovery;
use Required\Harvest\Api\ApiInterface;
use Required\Harvest\Exception\BadMethodCallException;
use Required\Harvest\Exception\InvalidArgumentException;
use Required\Harvest\HttpClient\Builder;
use Required\Harvest\HttpClient\Plugin\HarvestAuthentication;
use Required\Harvest\HttpClient\Plugin\ResponseExceptionThrower;

/**
 * The PHP client for consuming the Harvest REST API.
 *
 * @method \Required\Harvest\Api\Clients clients()
 * @method \Required\Harvest\Api\Contacts contacts()
 * @method \Required\Harvest\Api\CurrentUser currentUser()
 * @method \Required\Harvest\Api\CurrentCompany currentCompany()
 * @method \Required\Harvest\Api\EstimateItemCategories estimateItemCategories()
 * @method \Required\Harvest\Api\Estimates estimates()
 * @method \Required\Harvest\Api\ExpenseCategories expenseCategories()
 * @method \Required\Harvest\Api\Expenses expenses()
 * @method \Required\Harvest\Api\InvoiceItemCategories invoiceItemCategories()
 * @method \Required\Harvest\Api\Invoices invoices()
 * @method \Required\Harvest\Api\Projects projects()
 * @method \Required\Harvest\Api\Roles roles()
 * @method \Required\Harvest\Api\TaskAssignments taskAssignments()
 * @method \Required\Harvest\Api\Tasks tasks()
 * @method \Required\Harvest\Api\TimeEntries timeEntries()
 * @method \Required\Harvest\Api\UserAssignments userAssignments()
 * @method \Required\Harvest\Api\Users users()
 */
class Client {

	/**
	 * The builder for HTTP clients.
	 *
	 * @var \Required\Harvest\HttpClient\Builder
	 */
	protected $httpClientBuilder;

	/**
	 * Instantiate a new Harvest API client.
	 *
	 * @param \Required\Harvest\HttpClient\Builder|null $httpClientBuilder
	 */
	public function __construct( Builder $httpClientBuilder = null ) {
		$this->httpClientBuilder = $httpClientBuilder ?: new Builder();

		$this->httpClientBuilder->addPlugin( new ResponseExceptionThrower() );
		$this->httpClientBuilder->addPlugin( new Plugin\RedirectPlugin() );
		$this->httpClientBuilder->addPlugin( new Plugin\BaseUriPlugin( UriFactoryDiscovery::find()->createUri( 'https://api.harvestapp.com/v2' ) ) );
		$this->httpClientBuilder->addPlugin(
			new Plugin\HeaderDefaultsPlugin(
				[
					'User-Agent' => 'harvest-api-php-client (https://github.com/wearerequired/harvest-api-php-client)',
				]
			)
		);
	}

	/**
	 * Creates a Harvest\Client using a HttpClient.
	 *
	 * @param \Http\Client\HttpClient $httpClient The HttpClient.
	 * @return \Required\Harvest\Client Harvest API client.
	 */
	public static function createWithHttpClient( HttpClient $httpClient ) {
		$builder = new Builder( $httpClient );
		return new self( $builder );
	}

	/**
	 * Authenticates a user for all next requests.
	 *
	 * @link https://help.getharvest.com/api-v2/authentication-api/authentication/authentication/
	 *
	 * @param string $accountId   The Harvest account ID.
	 * @param string $accessToken The personal access token.
	 */
	public function authenticate( string $accountId, string $accessToken ): void {
		$this->getHttpClientBuilder()->removePlugin( HarvestAuthentication::class );
		$this->getHttpClientBuilder()->addPlugin( new HarvestAuthentication( $accountId, $accessToken ) );
	}

	/**
	 * Retrieves the API interface for an endpoint name.
	 *
	 * @throws \Required\Harvest\Exception\InvalidArgumentException
	 *
	 * @param string $name The endpoint name.
	 * @return \Required\Harvest\Api\ApiInterface The API interface.
	 */
	public function api( $name ): ApiInterface {
		switch ( $name ) {
			case 'clients':
				return new Api\Clients( $this );
			case 'contacts':
				return new Api\Contacts( $this );
			case 'me':
			case 'currentUser':
				return new Api\CurrentUser( $this );
			case 'currentCompany':
				return new Api\CurrentCompany( $this );
			case 'estimateItemCategories':
				return new Api\EstimateItemCategories( $this );
			case 'estimates':
				return new Api\Estimates( $this );
			case 'expenseCategories':
				return new Api\ExpenseCategories( $this );
			case 'expenses':
				return new Api\Expenses( $this );
			case 'invoiceItemCategories':
				return new Api\InvoiceItemCategories( $this );
			case 'invoices':
				return new Api\Invoices( $this );
			case 'projects':
				return new Api\Projects( $this );
			case 'roles':
				return new Api\Roles( $this );
			case 'taskAssignments':
				return new Api\TaskAssignments( $this );
			case 'tasks':
				return new Api\Tasks( $this );
			case 'timeEntries':
				return new Api\TimeEntries( $this );
			case 'userAssignments':
				return new Api\UserAssignments( $this );
			case 'users':
				return new Api\Users( $this );
			default:
				throw new InvalidArgumentException( sprintf( 'Undefined api instance called: "%s"', $name ) );
		}
	}

	/**
	 * Magic method to allow retrieving API interfaces by their name.
	 *
	 * @throws \Required\Harvest\Exception\BadMethodCallException
	 *
	 * @param string $name      The name of the method being called.
	 * @param array  $arguments The arguments passed to the method.
	 * @return \Required\Harvest\Api\ApiInterface The API interface.
	 */
	public function __call( string $name, array $arguments = [] ): ApiInterface {
		try {
			return $this->api( $name );
		} catch ( InvalidArgumentException $e ) {
			throw new BadMethodCallException( sprintf( 'Undefined method called: "%s"', $name ) );
		}
	}

	/**
	 * Retrieves the HTTP client.
	 *
	 * @return \Http\Client\Common\HttpMethodsClient
	 */
	public function getHttpClient(): HttpMethodsClient {
		return $this->getHttpClientBuilder()->getHttpClient();
	}

	/**
	 * Retrieves the builder for HTTP clients.
	 *
	 * @return \Required\Harvest\HttpClient\Builder
	 */
	protected function getHttpClientBuilder(): Builder {
		return $this->httpClientBuilder;
	}
}
