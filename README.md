# [slocomptech/docker-spyserver](https://github.com/SloCompTech/docker-spyserver)

Docker container for [AirSpy SpyServer](https://airspy.com/download).

[![](https://images.microbadger.com/badges/version/slocomptech/spyserver.svg)](https://microbadger.com/images/slocomptech/spyserver "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/slocomptech/spyserver.svg)](https://microbadger.com/images/slocomptech/spyserver "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/slocomptech/spyserver.svg)](https://microbadger.com/images/slocomptech/spyserver "Get your own commit badge on microbadger.com") ![](https://img.shields.io/docker/cloud/automated/slocomptech/spyserver.svg) ![](https://img.shields.io/docker/cloud/build/slocomptech/spyserver.svg)

## Usage

``` bash
# Block RTL-SDR default driver (reboot required)
echo "blacklist dvb_usb_rtl28xxu" >> /etc/modprobe.d/blacklist-rtl.conf

# Run container
docker run --rm -it --device=/dev/bus/usb -p 5555:5555 slocomptech/spyserver
```

## Parameters

|**Parameter**|**Function**|
|:-----------:|:----------:|
|`-e BIND_HOST=0.0.0.0`|Bind to IP address|
|`-e BIND_PORT=5555`|Port to run server on|
|`-e LIST_IN_DIRECTORY=0`|List Server in the [AirSpy Directory](https://airspy.com/directory/), 1 for yes, 0 for no|
|`-e OWNER_NAME=""`|Owner name shown in directory|
|`-e OWNER_EMAIL`|Owner email show in directory|
|`-e ANTENNA_TYPE=""`|Random Wire/Magnetic Loop/Mini-Whip/Inverted V/etc.|
|`-e ANTENNA_LOCATION=`|Lat/Long, eg. `48.858332, 2.294560`|
|`-e GENERAL_DESCRIPTION=""`|General Description for directory|
|`-e MAXIMUM_CLIENTS=0`|Maximum number of clients that can be connected at same time|
|`-e MAXIMUM_SESSION_DURATION=0`|Maximum seesion duration in minues. `0` for no limit|
|`-e ALLOW_CONTROL=1`|Allow clients to retune and change of gain of the device|
|`-e DEVICE_TYPE=Auto`|Possible Values: `AirspyOne (R0, R2, Mini)`, `AirspyHF+`, `RTL-SDR`, `Auto` (Scans for the first available device)|
|`-e DEVICE_SERIAL=""`|Device Serial Number as 64bit hex eg. `0xDD52D95C904534AD`. A value of `0` will acquire the first available device.|
|`-e DEVICE_SAMPLE_RATE=2500000`|Device Sample Rate, possible values: `AirspyOne (R0, R2)` (10000000 or 2500000), `AirspyOne Mini` (6000000 or 3000000), `AirspyHF+` (768000), `RTL-SDR` (500000 to 3200000), `Auto`|
|`-e FORCE_8BIT=1`|Force 8bit Compression Mode. The 8bit Compression mode has proven sufficiently good for most streaming use cases. Use it to save some internet bandwidth.|
|`-e MAXIMUM_BANDWIDTH=15000`|Maximum Bandwidth. Limits the maximum IQ bandwidth the clients can set. Recommended value for WFM is `200000`. Recommended value for narrow band modes is `15000`.|
|`-e FFT_FPS=15`|FFT Frames Per Second|
|`-e FFT_BIN_BITS=16`|FFT Bins, Bins = 2^fft_bin_bits|
|`-e INITIAL_FREQUENCY=7100000`|Initial Center Frequency|
|`-e MINIMUM_FREQUENCY=0`|Minimum Tunable Frequency|
|`-e MAXIMUM_FREQUENCY=35000000`|Maximum Tunable Frequency|
|`-e FREQUENCY_CORRECTION_PPB=0`|Frequency Correction in PPB|
|`-e INITIAL_GAIN=5`|Initial Gain|
|`-e RTL_SAMPLING_MODE=0`|RTL-SDR Sampling mode: Quadrature `0`, Direct Sampling I Branch = `1`,Direct Sampling Q Branch `2`|
|`-e CONVERTER_OFFSET=120000000`|Converter Offset, set to -120000000 to enable the SpyVerter offset|
|`-e ENABLE_BIAS_TEE=1`|For AirspyOne only - Useful for LNA's and SpyVerter|
|`-e BUFFER_SIZE_MS=50`|Buffer Size (in milliseconds)|
|`-e BUFFER_COUNT=10`|Buffer Count|
|`-e SKIP_APP=true`|Skip app startup|
|`-v /config`|Volume with config files|

See [upstream image](https://github.com/SloCompTech/docker-baseimage) for additional parameters.

## Documentation

- [AirSpy build from source](https://github.com/airspy/airspyone_host#how-to-build-the-host-software-on-linux)
- [AirSpy downloads](https://airspy.com/download)
- [AirSpy Quick start](https://airspy.com/quickstart/)
- [AirSpy tutorial](https://www.rtl-sdr.com/rtl-sdr-tutorial-setting-up-and-using-the-spyserver-remote-streaming-server-with-an-rtl-sdr/)
- [rtl_server tutorial 1](https://hamradioscience.com/raspberry-pi-as-remote-server-for-rtl2832u-sdr/)
