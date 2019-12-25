<?php
/**
 * ExceptionInterface interface.
 */

namespace Required\Harvest\Exception;

use Http\Client\Exception;

/**
 * Every HTTP Client related Exception must implement this interface.
 */
interface ExceptionInterface extends Exception {
}
