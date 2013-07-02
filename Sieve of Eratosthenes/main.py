''' =================================
 *
 *  Ronald Timoshenko | ronaldtimoshenko.com
 *  2013-06-27
 *
 * ================================= '''

def main():
    print(get_primes_in_range(2, 1000))


def get_primes_in_range(range_min, range_max):

    # Integrity Check
    assert range_min > 1, "range_min cannot be less than 2"
    assert range_max > range_min, "range_max must be greater than range_min"

    primes = range(range_min, range_max)

    for i in range(2, math.sqrt(range_max)):
        for j in range(i*i, range_max, i):
            primes[j] = None
            

    return primes

if __name__ == '__main__':
    main()
