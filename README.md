Welcome to the wonderful world of cross compilation. Where magic is possible and things break unexpectedly!

# What to find

What we're going to do here is to create a debian&ubuntu-based system with armhf cross-compilation capabilities. Since we won't be able to properly access the whole system, it mounts a suggested directory so that you can access the source-code for building purposes.

There's 1 way of building the SDK:
* (needs work) using docker that will give us something quite similar without requiring root privileges
    * that loses all changes every time we log out
    * where we can't access our local files.

# Docker
This one is using docker for setting up the facility and to set up the work. It has the advantage that it's much faster to set up and manage the system.

## Proposed workflow:
Create the image
```
cd image
docker build -t plasma-mobile-sdk .
```

Create the container instance for the needed project, see information about volumes.
```
docker create -ti --name myproject plasma-mobile-sdk bash
```
If you want to access the local filesystem to access the source code, consider specifying a docker volume (--volume /localpath:/dockerpath).
See [Docker Volumes Documentation](https://docs.docker.com/userguide/dockervolumes/) for more information.

Start the container for our project.
```
docker start -i myproject
```

## Docker things
Take into account that the files created within the image will be destroyed.


# Typical cmake command line

TODO: add this to the xutils

```
cmake .. \
 -DCMAKE_INSTALL_PREFIX=/usr \
 -DCMAKE_VERBOSE_MAKEFILE=ON \
 -DCMAKE_INSTALL_SYSCONFDIR=/etc \
 -DCMAKE_INSTALL_LOCALSTATEDIR=/var \
 -DCMAKE_SYSTEM_NAME=Linux \
 -DCMAKE_SYSTEM_PROCESSOR=arm \
 -DCMAKE_C_COMPILER=arm-linux-gnueabihf-gcc \
 -DCMAKE_CXX_COMPILER=arm-linux-gnueabihf-g++ \
 -DCMAKE_USE_RELATIVE_PATHS=ON \
 -DCMAKE_INSTALL_SYSCONFDIR=/etc\
 -DKDE_INSTALL_USE_QT_SYS_PATHS=OFF \
 -DQT_PLUGIN_INSTALL_DIR=/usr/lib/arm-linux-gnueabihf/qt5/plugins \
 -DQML_INSTALL_DIR=/usr/lib/arm-linux-gnueabihf/qt5/qml \
 -DKF5_HOST_TOOLING=/usr/lib/x86_64-linux-gnu/cmake
```

# Todo

- install all the kde frameworks packages
- fix the kde-development-environment for multi-arch (neon)
- document how qmake cross-compile works
