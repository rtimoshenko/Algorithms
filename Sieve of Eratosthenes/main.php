<?php

/* =================================
 *
 *  Ronald Timoshenko | ronaldtimoshenko.com
 *  2013-06-23
 *
 * ================================= */



// Error reporting and assertion
error_reporting(E_ALL);
ini_set('display_errors', '1');

assert_options(ASSERT_ACTIVE, 1);
assert_options(ASSERT_WARNING, 0);
assert_options(ASSERT_QUIET_EVAL, 1);
assert_options(ASSERT_CALLBACK, 'assert_handler');

function assert_handler($file, $line, $code)
{
    echo "Assertion failed at $file line: $line -> $code \n";
}






/*
* Return an array of prime numbers between the passed $min and $max range
*/
function getPrimesInRange($min, $max)
{
    // Integrity check
    assert('$min > 1  /* $min value cannot be less than 2 */');
    assert('$max >= $min  /* $min value must be greater than $max value */');
    
    // Implementation of Sieve of Eratosthenes
    // http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    
    $primes = array();

    // Odd numbers throw off the initial array index enumeration, 
    // so we subtract one for the initial loop
    $min = ($min % 2 == 0) ? $min : $min - 1;
    
    // Populate with all integers in range, initially
    for ($i = $min; $i < $max; $i++)
    {
        $primes[$i - $min + 2] = $i;
    }
        
    // Enumerate every integer from 2 up to the square root of the max
    for ($i = 2; $i < sqrt($max); $i++)
    {
        // If the index doesn't exist, then we've already removed it (i.e., it's not a prime)
        // when we enumerated smaller integers and it can be skipped
        if (isset($primes[$i]))
        {
            // Start with the square of the step, then continuosly increment the previous  
            // value by the step size since the sequence is:
            // n^2, n^2 + n, n^2 + 2n, ..., n
            for ($j = $i * $i; $j < $max; $j += $i)
            {
                // If we were able to get the value by multiplying two numbers together,
                // then the number is not a prime and we can remove it from the array
                unset($primes[$j]);
            }
        }
    }

    // Since we want all of the values within the range, we don't want
    // to return the min value
    if (reset($primes) == $min)
    {
        unset($primes[key($primes)]);
    }
    
    return array_values($primes);
}

// OUTPUT
var_dump(getPrimesInRange(2, 1000));

