<?php
/**
 * ErrorException class.
 */

namespace Required\Harvest\Exception;

/**
 * Every custom error exception must extend this class.
 */
class ErrorException extends \ErrorException implements ExceptionInterface {
}
