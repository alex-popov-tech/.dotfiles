<?php
/**
 * AutoPagingIterator class.
 */

namespace Required\Harvest\Api;

use Iterator;

/**
 * Iterator for automatic pagination for the all() endpoints.
 */
class AutoPagingIterator implements Iterator {

	/**
	 * Interface of the API endpoint.
	 *
	 * @var \Required\Harvest\Api\ApiInterface
	 */
	protected $apiInterface;

	/**
	 * Initial parameters for the request.
	 *
	 * @var array
	 */
	protected $parameters;

	/**
	 * Data of the last request.
	 *
	 * @var array
	 */
	protected $data;

	/**
	 * Offset for the key value.
	 *
	 * @var int
	 */
	protected $keyOffset = 0;

	/**
	 * Constructor.
	 *
	 * @param \Required\Harvest\Api\ApiInterface $apiInterface The API interface.
	 * @param array                              $parameters   Parameters for the all() method.
	 */
	public function __construct( ApiInterface $apiInterface, array $parameters = [] ) {
		$this->apiInterface = $apiInterface;
		$this->parameters   = $parameters;
	}

	/**
	 * Returns the current element.
	 *
	 * @return array Data of the current element.
	 */
	public function current() {
		return current( $this->data );
	}

	/**
	 * Moves forward to next element.
	 */
	public function next() {
		$item = next( $this->data );

		if ( false === $item && $this->apiInterface->hasMore() ) {
			$this->keyOffset += count( $this->data );
			$this->apiInterface->setPage( $this->apiInterface->getNextPage() );
			$this->data = $this->apiInterface->all( $this->parameters );
		}
	}

	/**
	 * Returns the key of the current element
	 *
	 * @return mixed Scalar on success, or null on failure.
	 */
	public function key() {
		return key( $this->data ) + $this->keyOffset;
	}

	/**
	 * Checks if current position is valid.
	 *
	 * @return bool  Returns true on success or false on failure.
	 */
	public function valid() {
		$key = key( $this->data );

		return null !== $key && false !== $key;
	}

	/**
	 * Rewind the Iterator to the first element.
	 */
	public function rewind() {
		$this->apiInterface->resetPagination();
		$this->data = $this->apiInterface->all( $this->parameters );
	}
}
