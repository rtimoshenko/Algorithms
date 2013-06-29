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
    // TODO: Add integrity checks

    // Implementation of Sieve of Eratosthenes
    // http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes

    // This would be more efficient with as a C function, instead of using the overhead of NSObjects
    // but is used here as a proof of concept
    
    NSNumber *zeroNum = [NSNumber numberWithInt:0];
    
    // Pad int array so that we can reference index 2 and prevent out of range exceptions
    NSMutableArray *ints = [[NSMutableArray alloc] initWithObjects:zeroNum, zeroNum, nil];
    NSMutableArray *primes = [[NSMutableArray alloc] init];
    
    int i, j;
    
    // No releases utilized due to ARC use
    @autoreleasepool
    {
        for (i = min; i < max; i++)
        {
            [ints setObject:[NSNumber numberWithInt:i] atIndexedSubscript:(i - min + 2)];
        }
        
        for (i = 2; i < sqrt(max); i++)
        {
            if([[ints objectAtIndex:i] intValue] > 0)
            {
                for (j = i * i; j < max; j += i)
                {
                    // Make sure we don't trigger out of range exceptions
                    if (j < ints.count)
                    {
                        // NSArrays can only hold NSObjects, so we set the value to an NSNumber with a zero int
                        [ints setObject:zeroNum atIndexedSubscript:j];
                    }
                }
            }
        }
        
        for (i = 0; i < ints.count; i++)
        {
            if ([[ints objectAtIndex:i] intValue] > 0 &&
                [[ints objectAtIndex:i] intValue] > [[NSNumber numberWithInt:min] intValue])
            {
                [primes addObject:[ints objectAtIndex:i]];
            }
        }
    }
    
    return primes;
}


@end
