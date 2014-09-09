1. Notice that, in the finished project, the IP addresses are stored as
integers in the DB. What are the pros and cons of this approach, compared
to storing the IP addresses as strings?

Using integers:
Pros - faster queries against the database, less storage space required
Cons - slower inserts and updates, conversion required to turn value back into IP string

Using strings
Pros - faster inserts and updates, no conversion required to get the IP string once retreived
Cons - slower queries, more storage space

Looking at the pros and cons for both I would stick with using integers, although the inserts 
and updates are slower they would be a very infrequent update and although there would be 
a calculation required to convert the IP into a string if you wanted to display it, this 
would be done on the client machine so if a large number of users were displaying IPs at once 
the database would have a lower load since the querying of an integer is much faster and the 
extra work required to convert the IP would take an unnoticeable amount of time on each clients machine

2. Are there any security issues present in the app itself? (No need to
mention security vulnerabilities within external gems.) List any security
issues you found, and how to fix them. Also list any potential security
issues that you investigated which you believe the site to be free of.

One security issue present in this application is the way in which it stores passwords.
I would use the salt approach that I detailed in the questionarre I got before this project.


Another threat would be Session Hijacking, this can be prevented by using the config.force_ssl = "true" command
in the config.ru file. This would force an SSL connection preventing Session Hijacking,as this is an app that 
requires a login you would normally be storing sensitive user information and SSL connections would be advised.



to run:
	1. bundle install
	2. rackup sync.ru -E production
	3. rails s
	