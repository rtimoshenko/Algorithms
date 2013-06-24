/* =================================
 *
 *  Ronald Timoshenko | ronaldtimoshenko.com
 *  2013-06-24
 *
 * ================================= */


/*
* Return an array of prime numbers between the passed min and max range
*/
function getPrimesInRange(min, max)
{
    "use strict";
    
    // Integrity checking
    if (min < 2)
    {
        throw "min value cannot be less than 2.";
    }
    if (min >= max)
    {
        throw "max value must be greater than min value.";
    }
        
    // Implementation of Sieve of Eratosthenes
    // http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    
    var i, j,
        ints = [],
        primes = [];

    // Initialize the integer array
    for (i = min; i < max; i++)
    {
        ints[i] = i;
    }

    // Enumerate every integer from 2 up to the square root of the max
    for (i = 2; i < Math.sqrt(max); i++)
    {
        // If the value at the current index is null (i.e., it's not a prime)
        // then we already checked it when we enumerated smaller integers and it can be skipped
        if (ints[i] !== null)
        {
            // Start with the square of the step, then continuosly increment the previous  
            // value by the step size since the sequence is:
            // n^2, n^2 + n, n^2 + 2n, ..., n
            for (j = i * i; j < max; j += i)
            {
                // If we were able to get the value by multiplying two integers together,
                // then the number is not a prime and we can set it to null
                ints[j] = null;
            }
        }
    }
    
    // At this point the sieve is complete, but since we want an array result,
    // we enumerate the integers again and push the primes to our result array
    for (i = min; i < max; i++)
    {
        if (ints[i] !== null)
        {
            primes.push(ints[i]);
        }
    }

    return primes;
}

// OUTPUT
console.log(getPrimesInRange(2, 1000));