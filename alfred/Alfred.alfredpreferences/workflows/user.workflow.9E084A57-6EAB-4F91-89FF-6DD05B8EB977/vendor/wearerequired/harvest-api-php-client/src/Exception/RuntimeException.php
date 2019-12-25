<?php
/**
 * RuntimeException class.
 */

namespace Required\Harvest\Exception;

/**
 * Exception thrown if an error which can only be found on runtime occurs.
 */
class RuntimeException extends \RuntimeException implements ExceptionInterface {
}
