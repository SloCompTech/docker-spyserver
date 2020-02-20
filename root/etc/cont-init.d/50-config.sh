#!/usr/bin/with-contenv bash
#
#   Setup /config directory
#

source $CONTAINER_VARS_FILE

CONFIG_FILE=/config/spyserver.config

[ -z "$BIND_HOST" ] || $RUNCMD sed -i "s/bind_host.*/bind_host = ${BIND_HOST:=0.0.0.0}/g" $CONFIG_FILE
[ -z "$BIND_PORT" ] || $RUNCMD sed -i "s/bind_port.*/bind_port = ${BIND_PORT:=5555}/g" $CONFIG_FILE
$RUNCMD sed -i "s/list_in_directory.*/list_in_directory = ${LIST_IN_DIRECTORY:=0}/g" $CONFIG_FILE
[ -z "$OWNER_NAME" ] || $RUNCMD sed -i "s/owner_name.*/owner_name = ${OWNER_NAME:=}/g" $CONFIG_FILE
[ -z "$OWNER_EMAIL" ] || $RUNCMD sed -i "s/owner_email.*/owner_email = ${OWNER_EMAIL:=}/g" $CONFIG_FILE
[ -z "$ANTENNA_TYPE" ] || $RUNCMD sed -i "s/antenna_type.*/antenna_type = ${ANTENNA_TYPE:=}/g" $CONFIG_FILE
[ -z "$ANTENNA_LOCATION" ] || $RUNCMD sed -i "s/antenna_location.*/antenna_location = ${ANTENNA_LOCATION:=}/g" $CONFIG_FILE
[ -z "$GENERAL_DESCRIPTION" ] || $RUNCMD sed -i "s/general_description.*/general_description = ${GENERAL_DESCRIPTION:=}/g" $CONFIG_FILE
[ -z "$MAXIMUM_CLIENTS" ] || $RUNCMD sed -i "s/maximum_clients.*/maximum_clients = ${MAXIMUM_CLIENTS:=1}/g" $CONFIG_FILE
[ -z "$MAXIMUM_SESSION_DURATION" ] || $RUNCMD sed -i "s/#maximum_session_duration.*/maximum_session_duration = ${MAXIMUM_SESSION_DURATION:=0}/g" $CONFIG_FILE
[ -z "$ALLOW_CONTROL" ] || $RUNCMD sed -i "s/allow_control.*/allow_control = ${ALLOW_CONTROL:=1}/g" $CONFIG_FILE
[ -z "$DEVICE_TYPE" ] || $RUNCMD sed -i "s/device_type.*/device_type = ${DEVICE_TYPE:=Auto}/g" $CONFIG_FILE
[ -z "$DEVICE_SERIAL" ] || $RUNCMD sed -i "s/device_serial.*/device_serial = ${DEVICE_SERIAL:=0}/g" $CONFIG_FILE
[ -z "$DEVICE_SAMPLE_RATE" ] || $RUNCMD sed -i "s/#device_sample_rate.*/device_sample_rate = ${DEVICE_SAMPLE_RATE:=2500000}/g" $CONFIG_FILE
[ -z "$FORCE_8BIT" ] || $RUNCMD sed -i "s/#force_8bit.*/force_8bit = ${FORCE_8BIT:=1}/g" $CONFIG_FILE
[ -z "$MAXIMUM_BANDWIDTH" ] || $RUNCMD sed -i "s/#maximum_bandwidth.*/maximum_bandwidth = ${MAXIMUM_BANDWIDTH:=15000}/g" $CONFIG_FILE
[ -z "$FFT_FPS" ] || $RUNCMD sed -i "s/fft_fps.*/fft_fps = ${FFT_FPS:=15}/g" $CONFIG_FILE
[ -z "$FFT_BIN_BITS" ] || $RUNCMD sed -i "s/fft_bin_bits.*/fft_bin_bits = ${FFT_BIN_BITS:=16}/g" $CONFIG_FILE
[ -z "$INITIAL_FREQUENCY" ] || $RUNCMD sed -i "s/#initial_frequency.*/initial_frequency = ${INITIAL_FREQUENCY:=7100000}/g" $CONFIG_FILE
[ -z "$MINIMUM_FREQUENCY" ] || $RUNCMD sed -i "s/#minimum_frequency.*/minimum_frequency = ${MINIMUM_FREQUENCY:=0}/g" $CONFIG_FILE
[ -z "$MAXIMUM_FREQUENCY" ] || $RUNCMD sed -i "s/#maximum_frequency.*/maximum_frequency = ${MAXIMUM_FREQUENCY:=35000000}/g" $CONFIG_FILE
[ -z "$FREQUENCY_CORRECTION_PPB" ] || $RUNCMD sed -i "s/#frequency_correction_ppb.*/frequency_correction_ppb = ${FREQUENCY_CORRECTION_PPB:=0}/g" $CONFIG_FILE
[ -z "$INITIAL_GAIN" ] || $RUNCMD sed -i "s/#initial_gain.*/initial_gain= ${INITIAL_GAIN:=5}/g" $CONFIG_FILE
[ -z "$RTL_SAMPLING_MODE" ] || $RUNCMD sed -i "s/#rtl_sampling_mode.*/rtl_sampling_mode = ${RTL_SAMPLING_MODE:=0}/g" $CONFIG_FILE
[ -z "$CONVERTER_OFFSET" ] || $RUNCMD sed -i "s/#converter_offset.*/converter_offset = ${CONVERTER_OFFSET:=-120000000}/g" $CONFIG_FILE
[ -z "$ENABLE_BIAS_TEE" ] || $RUNCMD sed -i "s/#enable_bias_tee.*/enable_bias_tee = ${ENABLE_BIAS_TEE:=0}/g" $CONFIG_FILE
[ -z "$BUFFER_SIZE_MS" ] || $RUNCMD sed -i "s/buffer_size_ms.*/buffer_size_ms = ${BUFFER_SIZE_MS:=50}/g" $CONFIG_FILE
[ -z "$BUFFER_COUNT" ] || $RUNCMD sed -i "s/buffer_count.*/buffer_count = ${BUFFER_COUNT:=10}/g" $CONFIG_FILE
