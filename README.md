# ProFTPD Minimum Viable Test
Small case for reproducing a situation where environment variables are not being properly substituted.

## Running
Very simple! Just do:
`docker-compose up -d --build`

And you should be good to connect to `127.0.0.1:21` with the `anonymous` user. The configuration is assuming PASSV.

## Expected Behavior
- PassivePorts should have it's lower bound set to 30000 and it's higher bound to 30050
- Various messages on Connect/Login/Quit should be displayed
- TLS should be strictly enforced

## Actual Behavior
Nothing gets substituted!