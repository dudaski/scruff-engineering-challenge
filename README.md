About
===============

A small command line utility for parsing and processing a JSON formatted file containing city data.

There are three operations that can be performed by the utility. They are as follows:

1. Return States with Populations above 10 Million
2. Return Average City Population by State
3. Return Largest and Smallest Cities by State

Usage
===============

Running
---------------

To perform a desired operation the utility takes parameters at execution.

To see the accepted parameter options simply run the `zips.rb` script with a help flag.

```bash
$ ./zips.rb -h
Usage: zips.rb [options]

  Available operations:
    1. Return States with Populations above 10 Million
    2. Return Average City Population by STATE
    3. Return Largest and Smallest Cities by STATE

    -o, --operation NUMBER           Select operation to perform by NUMBER
    -s, --state STATE                Return Average City Population by STATE code
    -h, --help                       Display help menu
```

Select an operation to perform by passing the operation parameter `-o, --operation NUMBER` to the script.

```bash
$ ./zips.rb -o 1
[
  {
    "_id": "NY",
    "pop": 17990402
  },
  {
    "_id": "PA",
    "pop": 11881643
  },
  {
    "_id": "FL",
    "pop": 12686644
  },
  {
    "_id": "OH",
    "pop": 10846517
  },
  {
    "_id": "IL",
    "pop": 11427576
  },
  {
    "_id": "TX",
    "pop": 16984601
  },
  {
    "_id": "CA",
    "pop": 29754890
  }
]
```

Unlike the first operation, the second and third require usage of the state parameter `-s, --state STATE`. The `STATE` value should be the two character state code. So if we wanted to know the average city population size in New Mexico we'd execute the script like:

```bash
$ ./zips.rb -o 2 -s NM
{
  "_id": "NM",
  "avgCityPop": 5489
}
```

Similarly for finding the cities in New Mexico with the largest and smallest populations.

```bash
$ ./zips.rb -o 3 -s NM
{
  "state": "NM",
  "biggestCity": {
    "name": "LAS CRUCES",
    "pop": 57502
  },
  "smallestCity": {
    "name": "ALGODONES",
    "pop": 0
  }
}
```

Where the data at?
---------------

By default the utility will look for a local relative file named `zips.json`. You can change this behavior by setting the `ZIPS_FILE` environment variable to another file.

Parser assumes data in the file adheres to the following format.

```
{
  "cities":[
    {
      "_id" : "01001",
      "city" : "AGAWAM",
      "loc" : [ -72.622739, 42.070206 ],
      "pop" : 15338,
      "state" : "MA"
    },
    ...
  ]
}
```

Testing
===============

To perform unit tests please make sure `rspec` is installed by first running `bundle install`.

Execute all unit tests:

```bash
bundle exec rspec
```
