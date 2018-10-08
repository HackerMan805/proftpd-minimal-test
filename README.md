# ProFTPD Minimum Viable Test
Small case for reproducing a situation where config directives do not seem to be respected.

## Running
Very simple! Just do:
`docker-compose up -d --build`

And you should be good to connect to `127.0.0.1:21` with the `anonymous` user. The configuration is assuming PASSV.

## Expected Behavior
- Server name should be broadcast as  "Minimum Viable Reproduction"
AWS Hosting 
- Various messages on Connect/Login/Quit should be displayed
`docker-compose up -d --build`
- TLS should be strictly enforced

## Actual Behavior
None of the above happens, but if you don't include the certs we specified in the config... ProFTPD fails to start.

/* CallingMethodsInSameClass.java
 *
 * illustrates how to call static methods a class
 * from a method in the same class
 */
