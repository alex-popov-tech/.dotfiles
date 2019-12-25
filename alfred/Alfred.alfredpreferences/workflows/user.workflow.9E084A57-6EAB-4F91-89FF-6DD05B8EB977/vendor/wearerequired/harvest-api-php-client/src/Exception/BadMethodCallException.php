<?php
/**
 * BadMethodCallException class.
 */

namespace Required\Harvest\Exception;

/**
 * Exception thrown if a callback refers to an undefined method or if some
 * arguments are missing..
 */
class BadMethodCallException extends \BadMethodCallException implements ExceptionInterface {
}
