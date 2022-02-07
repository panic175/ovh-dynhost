# ovh-dynhost
Docker image to update an OVH dynhost regularly. Based on Alpine linux.

### Why
A DynHost is used to assign a dynamic ip to multiple (sub)domaine (space separated).
This can be very useful to make your local development machine available via a public domaine.

### Configure OVH
In your OVH domain settings head over to the `DynHost` tab and follow the steps to create your dynhost.

### Run container

```yml
version: "3"

services:
  ovh-dynhost:
    build:
      context: https://github.com/panic175/ovh-dynhost
    environment:
      DYNHOST_DOMAIN_NAMES: dynhost1.example.com dynhost2.example.com
      DYNHOST_LOGIN: login
      DYNHOST_PASSWORD: password
```

Of course you need to insert your credentials.

You could use .env to provide the credentials
```yml
version: "3"

services:
  ovh-dynhost:
    build:
      context: https://github.com/panic175/ovh-dynhost
    restart: always
    environment:
      DYNHOST_DOMAIN_NAMES: dynhost1.example.com dynhost2.example.com
    env_file:
      - <path to env file>
```

This will update the dynhost at boot and every 15 minutes if the ip changed.

### Checking for problems
The docker container will echo debug messages whenever it tries to update the dynhost.
If you see `<title>401 Authorization Required</title>` you probably have an error in your credentials.

