This is a docker image for the [pi](https://pi.dev) agent.

The idea is to be able to then run it without any additional control, in its own docker container.

To build the image, run:

`# docker build -t pi-sandbox .`

The script `pi-sandbox` in the `bin/` folder starts a `pi` agent in a docker container in the folder where the ccommand is executed and mounts this folder inside the container under `/workspace`.
Additional environment variables and mappings can be given as arguments that will be automatically applied to the running container.
