# Docker image for the NXTP server


Quick and dirty docker wrapper around the [nxtp server](https://github.com/Threetwosevensixseven/nxtp), developed by [Robin Verhagen](https://github.com/Threetwosevensixseven)

### Build
```bash
docker build -t nxtp-server-test .
```

### Run
```bash
docker run -p 12300:12300 nxtp-server-test
```