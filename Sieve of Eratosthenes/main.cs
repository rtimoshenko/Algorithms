using System;

public class Main
{
    void Main()
    {
	    Console.Write(GetPrimesInRange(2, 1000));
    }

    // Define other methods and classes here

    IEnumerable<int> GetPrimesInRange(int min, int max)
    {
	    // Integrity check
	    Debug.Assert(min > 1, "min value cannot be less than 2.");
	    Debug.Assert(max > min, "max value must be greater than min value.");
	
	    var ints = new int?[max];
	
	    for (var i = min; i < max; i++)
	    {
		    ints[i] = i;
	    }
	
	    for (var i = 2; i < Math.Sqrt(max); i++)
	    {
		    if (ints[i] != null)
		    {
			    for (var j = i * i; j < max; j += i)
			    {
				    ints[j] = null;
			    }
		    }
	    }
	
	    foreach (var i in ints)
	    {
		    if (i != null)
		    {
			    yield return (int)i;
		    }
	    }
    }
}
