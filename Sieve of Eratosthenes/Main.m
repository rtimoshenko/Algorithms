/* =================================
 *
 *  Ronald Timoshenko | ronaldtimoshenko.com
 *  2013-06-28
 *
 * ================================= */


#import "Main.h"

@implementation Main

/*
 * Return an array of prime numbers between the passed min and max range
 */
- (NSArray *) primesInRangeWithMin:(int)min withMax:(int)max
{
    // Integrity check
    NSAssert(min > 1, @"min value cannot be less than 2.");
    NSAssert(max > min, @"max value must be greater than min value.");
    
    // Implementation of Sieve of Eratosthenes
    // http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
    
    // This would be more efficient with as a C function, instead of using the overhead of NSObjects
    // but is used here as a proof of concept
    
    NSNumber *zeroNum = [NSNumber numberWithInt:0];
    
    // Pad int array so that we can reference index 2 and prevent out of range exceptions
    NSMutableArray *ints = [[NSMutableArray alloc] initWithObjects:zeroNum, zeroNum, nil];
    NSMutableArray *primes = [[NSMutableArray alloc] init];
    
    int i, j;
    
    // Odd numbers throw off the initial array index enumeration, 
    // so we subtract one for the initial loop
    int originalMin = min;
    min = (min % 2 == 0) ? min : min - 1;
    
    // No releases utilized due to ARC use
    @autoreleasepool
    {
        // Populate with all integers in range, initially
        for (i = min; i < max; i++)
        {
            [ints setObject:[NSNumber numberWithInt:i] atIndexedSubscript:(i - min + 2)];
        }
        
        // Enumerate every integer from 2 up to the square root of the max
        for (i = 2; i < sqrt(max); i++)
        {
            // If the intValue of the object at the index is zero, then we've already removed it
            // (i.e., it's not a prime) when we enumerated smaller integers and it can be skipped
            if([[ints objectAtIndex:i] intValue] > 0)
            {
                // Start with the square of the step, then continuosly increment the previous
                // value by the step size since the sequence is:
                // n^2, n^2 + n, n^2 + 2n, ..., n
                for (j = i * i; j < max; j += i)
                {
                    // Make sure we don't trigger out of range exceptions
                    if (j < ints.count)
                    {
                        // If we were able to get the value by multiplying two numbers together,
                        // then the number is not a prime and we set its value to zero;
                        // NSArrays can only hold NSObjects, so we set the value to an NSNumber with a zero int
                        [ints setObject:zeroNum atIndexedSubscript:j];
                    }
                }
            }
        }
        
        // At this point the sieve is complete, but since we want an array result,
        // we enumerate the integers again and push the primes to our result array
        for (i = 0; i < ints.count; i++)
        {
            if ([[ints objectAtIndex:i] intValue] > 0 &&
                [[ints objectAtIndex:i] intValue] > [[NSNumber numberWithInt:originalMin] intValue])
            {
                [primes addObject:[ints objectAtIndex:i]];
            }
        }
    }
    
    return primes;
}


@end
