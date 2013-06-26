/* =================================
 *
 * 	Ronald Timoshenko | ronaldtimoshenko.com
 * 	2013-06-25
 *
 * ================================= */

using System;

public class Main
{
    void Main()
    {
	    Console.Write(GetPrimesInRange(2, 1000));
    }

    IEnumerable<int> GetPrimesInRange(int min, int max)
    {
	    // Integrity check
	    Debug.Assert(min > 1, "min value cannot be less than 2.");
	    Debug.Assert(max > min, "max value must be greater than min value.");

		// Implementation of Sieve of Eratosthenes
		// http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
	
		// Initialize nullable integer array with length of max
	    var ints = new int?[max];
	    int i, j;
	
		// Populate ints array with all integers in range, initially
	    for (i = min; i < max; i++)
	    {
		    ints[i - min + 2] = i;
	    }
	
		// Enumerate every integer from 2 up to the square root of the max
	    for (i = 2; i < Math.Sqrt(max); i++)
	    {
			// If the index is null, then we've already marked it (i.e., it's not a prime)
			// as non-prime when we enumerated smaller integers and it can be skipped
		    if (ints[i] != null)
		    {
				// Start with the square of the step, then continuosly increment the previous  
				// value by the step size since the sequence is:
				// n^2, n^2 + n, n^2 + 2n, ..., n
			    for (j = i * i; j < max; j += i)
			    {
					// If we were able to get the value by multiplying two numbers together,
					// then the number is not a prime and we can set it to null
				    ints[j] = null;
			    }
		    }
	    }
	
	    // At this point the sieve is complete, but since we want an array result,
	    // we enumerate the integers again and yield the primes
	    foreach (var n in ints)
	    {
		    if (n != null && n > min)
		    {
			    yield return (int)n;
		    }
	    }
    }
}
