# Parser

This is a coding exercise. The original requirements were to create a command line script
that would parse a file containing a webserver access log and count and present every hit,
and every unique hit.

I have packaged this up as a gem. Maybe a bit overkill, but gem project structure is as good a project structure as any, and its got some freebies in terms of pain free distribution of executables.

## Installation

This is a gemified distribution of a command line utility. So the appropriate usage is

`$ gem install parser # TODO: complete the right URLs`

But you could of course add it to an existing gemfile.

```ruby
gem 'parser' # TODO share out the git link
```

And then execute:

    $ bundle install

## Usage

`$ exe/parser <path to logfile>`

where the logfile is in the format of

```bash
/index 192.168.1.1
/help 201.10.10.155
```
Where the first part is a path reference, and the second is an IP address.
In practice the tool is not strict about RFC standards:

```bash
¯\_(ツ)_/¯ unos.dos.tres.quattro
```
is just as valid as RFC compliant paths / urls and ip addresses. For anything it does disagree with it will print out the line an line number in the input that it had issue with.

## Problem Approach

My main goals here were
- solve the asked for problem
- keep it easy to read
- good testing, driven from an integration level
- good ruby practices leaning on SOLID principles for familiar structure and extensibilty
- play about a bit with using a gem as a wrapper for a CLI

### Lessons learned

I have kept my commit history ungroomed. I get interrupted/distracted a lot, and have to park the work or pick up later, so I am usually trying to cram in useful bits of work between interruptions.

I dont often go about trying to test CLIs at a console level, ie. verifying output behaviour by examining STDOUT. Tried it here, having forgotten why I swore of doing it last time. Testing at the integration level was pretty good, and it covered the main code well according to the reports, but it got tedious trying to fix these. I reworked everything to dependency inject an IO replacement, there is a nicer abstraction for this I am sure but it wasnt immediately available.

A singleton data structure for storing results worked very nicely until it leaked state between tests. I ended up Dependency injecting this everywhere, which was a bit of a kludge. It feels like a more elegant approach could have been achieved.

Testing at the integration level covered a lot of the code, especially when I went manually building my own fixtures to confirm results. There was a lot of headroom there for continuing the testing style in that manner.

There is some repeat testing in the code, but I never found an opportunity to start leveraging shared examples etc.

I didnt trust the coverage reports and backfilled unit tests around complex code in the query classes afterwards.

I leaned heavily on rubocop / simplecov / reek once tests went green. For the most part kept the defaults.

I didnt over think the namespacing of the code, but the top level namespace feels like some of those classes belong elsewhere. It does feel like some other abstractions could have been teased out (like formatting of messages).

### In conclusion

So mostly adhered to SOLID principles for everything, and drove correctness through integration tests. I didnt go down the rabbit hole of regex-fu or RFC correctness, but left the tests in a good place state that those requirement could be done in a test driven way.

I am happy enough with the relationship between repository - report formatter - data query. All of these feel quite easily extensible.

