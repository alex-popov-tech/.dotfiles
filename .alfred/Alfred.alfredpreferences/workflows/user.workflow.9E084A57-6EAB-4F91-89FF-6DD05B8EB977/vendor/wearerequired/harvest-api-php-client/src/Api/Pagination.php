<?php
/**
 * Pagination class.
 */

namespace Required\Harvest\Api;

/**
 * Class used to store and retrieve pagination parameters.
 */
class Pagination {

	/**
	 * The requested page.
	 *
	 * @var null|int
	 */
	protected $page;

	/**
	 * The next page number.
	 *
	 * @var null|int
	 */
	protected $nextPage;

	/**
	 * The previous page number.
	 *
	 * @var null|int
	 */
	protected $previousPage;

	/**
	 * Number of items per page.
	 *
	 * @var null|int
	 */
	protected $perPage;

	/**
	 * Number of total pages.
	 *
	 * @var null|int
	 */
	protected $totalPages;

	/**
	 * Number of total pages.
	 *
	 * @var null|int
	 */
	protected $totalEntries;

	/**
	 * Retrieves requested page number.
	 *
	 * @return null|int
	 */
	public function getPage(): ?int {
		return $this->page;
	}

	/**
	 * Sets requested page number.
	 *
	 * @param null|int $page The requested page.
	 */
	public function setPage( $page ): void {
		$this->page = ( null === $page ? $page : (int) $page );
	}

	/**
	 * Retrieves next page number.
	 *
	 * @return null|int
	 */
	public function getNextPage(): ?int {
		return $this->nextPage;
	}

	/**
	 * Sets next page number.
	 *
	 * @param null|int $nextPage The next page.
	 */
	public function setNextPage( $nextPage ): void {
		$this->nextPage = ( null === $nextPage ? $nextPage : (int) $nextPage );
	}

	/**
	 * Retrieves previous page number.
	 *
	 * @return null|int
	 */
	public function getPreviousPage(): ?int {
		return $this->previousPage;
	}

	/**
	 * Sets previous page number.
	 *
	 * @param null|int $previousPage The previous page.
	 */
	public function setPreviousPage( $previousPage ): void {
		$this->previousPage = ( null === $previousPage ? $previousPage : (int) $previousPage );
	}

	/**
	 * Retrieves number of items per page.
	 *
	 * @return null|int
	 */
	public function getPerPage(): ?int {
		return $this->perPage;
	}

	/**
	 * Sets number of items per page.
	 *
	 * @param null|int $perPage Number of items per page.
	 */
	public function setPerPage( $perPage ): void {
		$this->perPage = ( null === $perPage ? $perPage : (int) $perPage );
	}

	/**
	 * Retrieves total pages number.
	 *
	 * @return null|int
	 */
	public function getTotalPages(): ?int {
		return $this->totalPages;
	}

	/**
	 * Sets number of total pages.
	 *
	 * @param null|int $totalPages Number of total pages.
	 */
	public function setTotalPages( $totalPages ): void {
		$this->totalPages = ( null === $totalPages ? $totalPages : (int) $totalPages );
	}

	/**
	 * Retrieves total entries number.
	 *
	 * @return null|int
	 */
	public function getTotalEntries(): ?int {
		return $this->totalPages;
	}

	/**
	 * Sets number of total entries.
	 *
	 * @param null|int $totalEntries Number of total entries.
	 */
	public function setTotalEntries( $totalEntries ): void {
		$this->totalEntries = ( null === $totalEntries ? $totalEntries : (int) $totalEntries );
	}

	/**
	 * Whether the current request has a next page.
	 *
	 * @return bool True if next page exists, false if not.
	 */
	public function hasMore() {
		return null === $this->totalEntries || null !== $this->nextPage;
	}

	/**
	 * Resets page properties to initial state.
	 */
	public function reset() {
		$this->page         = null;
		$this->nextPage     = null;
		$this->previousPage = null;
		$this->perPage      = null;
		$this->totalPages   = null;
		$this->totalEntries = null;
	}
}
