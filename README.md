
<!--#echo json="package.json" key="name" underline="=" -->
donnerwetter-archiver-pmb
=========================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Download weather data from DonnerWetter.de before they censor it.
<!--/#echo -->


My problem
----------

I like the weather predictions from
[DonnerWetter.de](https://www.donnerwetter.de/),
but they have this annoying habit of censoring past data.
Except in the first three hours of a day,
this habit makes it hard to compare today and the next two days side-by-side,
because in the "today" page there will be time slots missing,
so the others climb up and they don't align anymore.



My old workaround
-----------------

This script requests archival of relevant predictions
in the WayBack Machine.
My cron daemon runs it daily soon after midnight,
when all time slots are still being shown.

I then use a very hacky and non-portable frameset contraption to
make my browser show the relevant parts of the archived pages in
iFrames, next to each other.



The real solution
-----------------

… would be to parse their data, save it to a local database,
and render it using my own display mechanism.




<!--#toc stop="scan" -->



Known issues
------------

* Needs more/better tests and docs.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
