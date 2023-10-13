https://sharp.pixelplumbing.com/install#prebuilt-libvips-binaries

```
To install the prebuilt libvips binaries from a custom URL, set the sharp_libvips_binary_host npm config option or the npm_config_sharp_libvips_binary_host environment variable.

To install the prebuilt libvips binaries from a directory on the local filesystem, set the sharp_libvips_local_prebuilds npm config option or the npm_config_sharp_libvips_local_prebuilds environment variable.

The version subpath and filename are appended to these.

URL example: if sharp_libvips_binary_host is set to https://hostname/path and the libvips version is 4.5.6 then the resultant URL will be https://hostname/path/v4.5.6/libvips-4.5.6-platform-arch.tar.br.
```

## Dockerでlibvipsをコンパイル

```
docker build -t libvips-ubuntu .
```

```
docker create --name libvips-temp-container libvips-ubuntu
```

```
docker cp libvips-temp-container:/output/vips ./vips
```

## バイナリの圧縮

```
tar cf libvips-8.14.5-linux-x64.tar vips
brotli libvips-8.14.5-linux-x64.tar
```

## ダウンロードURL
```
https://github.com/NaitoYuki/libvips/raw/master/v.8.14.5/libvips-8.14.5-linux-x64.tar.br
```
