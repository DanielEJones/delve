# delve
A small networked videogame about going deeper.

## Building for Yourself
To compile for development/testing you can run the following:
```bash
make main               # Build a unified dev build
./bin/main --server     # Start a server running
./bin/main --client     # Start a client running
```

To compile for release you can run one or both of the following:
```bash
make server     # Build a release mode server
make client     # Build a release mode client

./bin/server    # Start a server running
./bin/client    # Start a client running
```
