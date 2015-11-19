# -*- coding: utf-8 -*-
import i3pystatus

status = i3pystatus.Status(standalone=True)

status.register(
    "clock",
    format="%Y-%m-%d %H:%M:%S",)

status.register(
    "weather",
    location_code="AUXX0010",
    colorize=True,
    interval=600,
    format="INN {current_temp} ({min_temp}/{max_temp})",)

status.register(
    "battery",
    format="B {status}{percentage:.0f}%",
    full_color="#ffffff",
    not_present_text="",
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "",
    },)

status.register(
    "network",
    format_up="{interface} ↗{bytes_sent}kB/s ↘{bytes_recv}kB/s",
    format_down='',
    dynamic_color=False,
    start_color="#ffffff",
    interface="wlan0",)

status.register(
    "network",
    format_up="{interface} ↗{bytes_sent}kB/s ↘{bytes_recv}kB/s",
    format_down='',
    dynamic_color=False,
    start_color="#ffffff",
    interface="eth0",)

status.register(
    "network",
    format_up="{interface} ↗{bytes_sent}kB/s ↘{bytes_recv}kB/s",
    format_down='',
    dynamic_color=False,
    start_color="#ffffff",
    interface="usb0",)

status.register(
    "load",
    format="L {avg1} {avg5}",)

status.register(
    "temp",
    format="{temp:.0f}°C",)

status.register(
    "cpu_usage",
    format="CPU {usage}%",)

status.register(
    "mem",
    divisor=1024**3,
    color="#ffffff",
    format="MEM {used_mem}/{total_mem}GB",)

status.register(
    "disk",
    path="/home",
    format="/home ◕ {avail}G",)

status.register(
    "disk",
    path="/",
    format="/ ◕ {avail}G",)


status.run()
