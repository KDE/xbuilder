Welcome to the wonderful world of cross compilation. Where magic is possible and things break unexpectedly!

# What to find

What we're going to do here is to create a debian&ubuntu-based system with armhf cross-compilation capabilities. Since we won't be able to properly access the whole system, it mounts a suggested directory so that you can access the source-code for building purposes.

There's 2 ways of building the SDK:
* using the old-school chroot, where we'll get an environment to develop on
* (EXPERIMENTAL, needs work) using docker that will give us something quite similar without requiring root privileges
    * that loses all changes every time we log out
    * where we can't access our local files.

# Old-school chroot
To get get started we'll do the following:

`sudo ./setup.sh <your projects path>`

This will take a while. You can grab a cup of $YOUR_FAVORITE_DRINK.

Once it's ready, you'll get a "go-mobile" executable that will let you in the system, you just need to execute it.

` ./go-mobile `

That should give you a workable environment.

Check `xutils` repository to see some extra available tools inside


# Docker
## Build Docker image
```
# cd image
# docker build -t pms .
```

## Execute
This will execute the image
```
docker run -ti pms bash
```

If you want to import local source code, use --volume:
`docker run -ti -v /home/kde-devel/frameworks:/src pms bash` where `/home/kde-devel/frameworks` is the sources directory.

## Docker things
Take into account that the files created within the image will be destroyed.

# Tips
While configuring a project with cmake, is important to add
the following in order to cmake to work a second time
`-DCMAKE_TOOLCHAIN_FILE=/usr/share/cmake-3.0/Modules/MultiArchCross.cmake`
