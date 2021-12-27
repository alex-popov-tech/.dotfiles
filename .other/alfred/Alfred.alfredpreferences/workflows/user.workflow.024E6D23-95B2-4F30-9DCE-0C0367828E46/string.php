<?php
/**
 * Function for Random String Generator with Alfred.
 * 
 * @package Random String Generator
 * @author Justin Kopepasah
 * @version 1.0.0
*/

function generate_string( $query ) {
	/**
	 * Create the new workflow instance.
	 * 
	 * @since 1.0.0
	*/
	$workflow = new Workflows();
	
	/**
	 * Convert query to an array by using spaces as
	 * the delimiter and then remove any empty values.
	 * 
	 * @since 1.0.0
	*/
	$query = explode( ' ', $query );
	
	/**
	 * Set the parameters array.
	 * 
	 * @since 1.0.0
	*/
	$params = array(
		'upper'  => 'ABCDEFGHIJKLMNOPQRSTUVWXYZ',
		'lower'  => 'abcefghijklmnopqrstuvwxyz',
		'number' => '0123456789',
		'crazy'  => '_-~!@#$%^><,.'
	);
	
	/**
	 * Builder the string.
	 * 
	 * @since 1.0.0
	*/
	if ( $query[1] ) {
		if ( 'u' == $query[1] ) {
			$key = $params['upper'];
		} else if ( 'l' == $query[1] ) {
			$key = $params['lower'];
		} else if ( 'n' == $query[1] ) {
			$key = $params['number'];
		} else if ( 'nu' == $query[1] ) {
			$key = $params['lower'] . $params['number'];
		} else if ( 'nl' == $query[1] ) {
			$key = $params['upper'] . $params['number'];
		} else if ( 'nn' == $query[1] ) {
			$key = $params['upper'] . $params['lower'];
		} else if ( 'c' == $query[1] ) {
			$key = $params['upper'] . $params['lower'] . $params['number'] . $params['crazy'];
		} else {
			$key = $params['upper'] . $params['lower'] . $params['number'] . $query[1];
		}
	} else {
		$key = $params['upper'] . $params['lower'] . $params['number'];
	}
	
	$key = substr( str_shuffle( $key ), 0, $query[0] );
	
	/**
	 * Create and copy the string.
	 * 
	 * @since 1.0.0
	*/
	$workflow->result( '', $key, 'Your String: ' . $key, 'Press Return to copy to clipboard', 'icon.png' );
	
	/**
	 * Echo the New string.
	 * 
	 * @since 1.0.0
	*/
	echo $workflow->toxml();
}

