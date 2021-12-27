<?php
/**
 * Builder class.
 */

namespace Required\Harvest\HttpClient;

use Http\Client\Common\HttpMethodsClient;
use Http\Client\Common\Plugin;
use Http\Client\Common\Plugin\Cache\Generator\HeaderCacheKeyGenerator;
use Http\Client\Common\PluginClientFactory;
use Http\Client\HttpClient;
use Http\Discovery\HttpClientDiscovery;
use Http\Discovery\MessageFactoryDiscovery;
use Http\Discovery\StreamFactoryDiscovery;
use Http\Message\RequestFactory;
use Http\Message\StreamFactory;
use Psr\Cache\CacheItemPoolInterface;

/**
 * A builder that builds the API client.
 */
class Builder {

	/**
	 * The object that sends HTTP messages.
	 *
	 * @var \Http\Client\HttpClient
	 */
	private $httpClient;

	/**
	 * A HTTP client with all plugins.
	 *
	 * @var \Http\Client\Common\HttpMethodsClient
	 */
	private $pluginClient;

	/**
	 * @var \Http\Message\RequestFactory
	 */
	private $requestFactory;

	/**
	 * @var \Http\Message\StreamFactory
	 */
	private $streamFactory;

	/**
	 * True if a new Plugin client should be created at next request.
	 *
	 * @var bool
	 */
	private $httpClientModified = true;

	/**
	 * @var \Http\Client\Common\Plugin[]
	 */
	private $plugins = [];

	/**
	 * This plugin is special treated because it has to be the very last plugin.
	 *
	 * @var \Http\Client\Common\Plugin\CachePlugin
	 */
	private $cachePlugin;

	/**
	 * HTTP headers.
	 *
	 * @var array
	 */
	private $headers = [];

	/**
	 * Constructor.
	 *
	 * @param HttpClient $httpClient
	 * @param RequestFactory $requestFactory
	 * @param StreamFactory  $streamFactory
	 */
	public function __construct(
		HttpClient $httpClient = null,
		RequestFactory $requestFactory = null,
		StreamFactory $streamFactory = null
	) {
		$this->httpClient     = $httpClient ?: HttpClientDiscovery::find();
		$this->requestFactory = $requestFactory ?: MessageFactoryDiscovery::find();
		$this->streamFactory  = $streamFactory ?: StreamFactoryDiscovery::find();
	}

	/**
	 * Gets the HTTP client with all the plugins.
	 *
	 * @return \Http\Client\Common\HttpMethodsClient
	 */
	public function getHttpClient(): HttpMethodsClient {
		if ( $this->httpClientModified ) {
			$this->httpClientModified = false;

			$plugins = $this->plugins;
			if ( $this->cachePlugin ) {
				$plugins[] = $this->cachePlugin;
			}

			$this->pluginClient = new HttpMethodsClient(
				( new PluginClientFactory() )->createClient( $this->httpClient, $plugins ),
				$this->requestFactory
			);
		}

		return $this->pluginClient;
	}

	/**
	 * Adds a new plugin to the end of the plugin chain.
	 *
	 * @param \Http\Client\Common\Plugin $plugin The plugin.
	 */
	public function addPlugin( Plugin $plugin ): void {
		$this->plugins[]          = $plugin;
		$this->httpClientModified = true;
	}

	/**
	 * Removes a plugin by its fully qualified class name (FQCN).
	 *
	 * @param string $fqcn The fully qualified class name.
	 */
	public function removePlugin( $fqcn ): void {
		foreach ( $this->plugins as $idx => $plugin ) {
			if ( $plugin instanceof $fqcn ) {
				unset( $this->plugins[ $idx ] );
				$this->httpClientModified = true;
			}
		}
	}

	/**
	 * Clears used headers.
	 */
	public function clearHeaders(): void {
		$this->headers = [];

		$this->removePlugin( Plugin\HeaderAppendPlugin::class );
		$this->addPlugin( new Plugin\HeaderAppendPlugin( $this->headers ) );
	}

	/**
	 * Adds a list of headers to the request.
	 *
	 * @param array $headers
	 */
	public function addHeaders( array $headers ): void {
		$this->headers = array_merge( $this->headers, $headers );

		$this->removePlugin( Plugin\HeaderAppendPlugin::class );
		$this->addPlugin( new Plugin\HeaderAppendPlugin( $this->headers ) );
	}

	/**
	 * Adds a header to the request.
	 *
	 * @param string $header
	 * @param string $headerValue
	 */
	public function addHeaderValue( string $header, string $headerValue ): void {
		if ( ! isset( $this->headers[ $header ] ) ) {
			$this->headers[ $header ] = $headerValue;
		} else {
			$this->headers[ $header ] = array_merge( (array) $this->headers[ $header ], [ $headerValue ] );
		}

		$this->removePlugin( Plugin\HeaderAppendPlugin::class );
		$this->addPlugin( new Plugin\HeaderAppendPlugin( $this->headers ) );
	}

	/**
	 * Adds a cache plugin to cache responses locally.
	 *
	 * @param CacheItemPoolInterface $cachePool A cache item object.
	 * @param array                  $config    Config options passed to the cache plugin.
	 */
	public function addCache( CacheItemPoolInterface $cachePool, array $config = [] ): void {
		if ( ! isset( $config['cache_key_generator'] ) ) {
			$config['cache_key_generator'] = new HeaderCacheKeyGenerator(
				[
				'Authorization',
				'Harvest-Account-Id',
				'Cookie',
				'Accept',
				'Content-type',
				 ]
			);
		}

		$this->cachePlugin        = Plugin\CachePlugin::clientCache( $cachePool, $this->streamFactory, $config );
		$this->httpClientModified = true;
	}

	/**
	 * Removes the cache plugin.
	 */
	public function removeCache(): void {
		$this->cachePlugin        = null;
		$this->httpClientModified = true;
	}
}
