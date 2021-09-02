#!/bin/bash

rm -f /tmp/firecracker.socket
firecracker-0.24.6/firecracker-v0.24.6-x86_64 --api-sock /tmp/firecracker.socket
