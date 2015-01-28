
tf2-server-docker
==================

This is a set of a Dockerfile and a script that will create a container that runs a [Team Fortress 2](http://www.garrysmod.com/) Server. 

### Examples

Start a server on port 27015:

`docker run -d -p 27015:27015/udp suchipi/tf2-server`


### Notes

######Environment Variables
You can set the environment variables `MAXPLAYERS`, `MAP`, `G_HOSTNAME`, `SV_PURE` and `ARGS` to change the startup arguments to the srcds_run command. For example:

`docker run -d -P -e MAXPLAYERS=32 -e MAP=ctf_2fort -e SV_PURE=0 -e G_HOSTNAME="CTF 2FORT Server" -e ARGS="-insecure +exec something.cfg" suchipi/tf2-server`

The defaults for the environment variables are as follows:

| Environment Variable |        Default |
|----------------------|---------------:|
| SV_PURE              |              1 |
| MAP                  |   koth_nucleus |
| MAXPLAYERS           |             24 |
| G_HOSTNAME           | My TF2 Server  |
| ARGS                 | (empty string) |

The `ARGS` variable is just added into the run command, right before the map is set with +map.

######Master Servers
The Source Engine doesn't seem to find out which port it's *actually* running on, so it tells the master servers that it's running on 27015 (or whatever `-port` you specified at runtime) even if you assign with `-P` dynamically. I've explored several potential solutions to this but the bottom line is that the Source Engine Dedicated Server wasn't really set up with this type of NATing in mind (or maybe, for that matter, any type of NAT). If you want this piece to work properly, you should probably just use the same port on the docker host as within the container. 

The main thing that this affects is that if player A tries to join player B through Steam, Steam will tell player A to connect to port 27015 (the port the master server reports) even if player B is truly connected to a different port. This also affects `steam://connect/` links.

To use a port other than 27015 both within and outside the container, you could do something like:

`docker run -d -p 27016:27016/udp -e ARGS="-port 27016" suchipi/tf2-server`

which tells srcds inside the container to bind to 27016, and then forwards the internal 27016 to your external 27016.

######Other
`build.sh` is just a convenience script; it isn't used by the Dockerfile.
