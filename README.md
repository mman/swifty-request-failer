# swifty-request-failer

This package demonstrates a bug in swift 5.1 on linux where multiple concurrent URLSession tasks start to time out.

Works fine under linux swift 5.0, as well as under swift 5.1 on macOS.

To quickly run inside swift 5.0 linux docker:

```
$ docker run -v `pwd`:/swifty-request-failer -it swift:5.0 bash
```

To quickly run inside swift 5.1 linux docker:

```
$ docker run -v `pwd`:/swifty-request-failer -it swift:5.1 bash
```

After getting to the docker container:

```
# cd /swifty-request-failer
# swift package clean
# swift build
# .build/debug/swifty-request-failer
```

Watch whether the requests return expected HTTP 204 or whether they timeout. Note: they should never timeout as long as your internet is working fine.

