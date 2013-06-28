//
//  Main.m
//  
//
//  Created by Ronald Timoshenko on 6/28/13.
//
//

#import "Main.h"

@implementation Main


-(NSMutableArray *) primesInRange:(int)min withMax:(int)max
{
    NSMutableArray *ints = [[NSMutableArray alloc] initWithCapacity:max];
    NSMutableArray *primes = [[NSMutableArray alloc] init];
    NSNumber *zeroNum = [NSNumber numberWithInt:0];
    
    int i, j;
    
    for (i = min; i < max; i++)
    {
        [ints addObject:[NSNumber numberWithInt:(i - min + 2)]];
    }
    
    for (i = 2; i < sqrt(max); i++)
    {
        if([ints objectAtIndex:i] != nil)
        {
            for (j = i * i; j < max; j += i)
            {
                [ints setObject:zeroNum atIndexedSubscript:j];
            }
        }
    }
    
    for (i = 0; i < ints.count; i++)
    {
        if ([ints objectAtIndex:i] > 0)
        {
            [primes addObject:primes];
        }
    }
    
    return primes;
}


@end
