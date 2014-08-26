# -*- coding: utf-8 -*-
import i3pystatus

from i3pystatus.core.util import round_dict
import psutil
class NetworkTraffic(i3pystatus.IntervalModule):
    """
    Network traffic info per interface

    Available formatters:

    * `{interface}` — the configured network interface
    * `{bytes_sent}` — bytes sent per second (divided by divisor)
    * `{bytes_recv}` — bytes received per second (divided by divisor)
    * `{packets_sent}` — bytes sent per second (divided by divisor)
    * `{packets_recv}` — bytes received per second (divided by divisor)
    """
    interval = 1
    settings = (
        ("format", "format string"),
        ("interface", "network interface"),
        ("divisor", "divide all byte values by this value"),
        ("round_size", "defines number of digits in round"),
    )
    interface = "eth0"
    format = "{interface} \u2197{bytes_sent}kB/s \u2198{bytes_recv}kB/s"
    divisor = 1024
    round_size = None
    pnic = None
    def run(self):
        pnic_before = self.pnic
        self.pnic = psutil.net_io_counters(pernic=True)[self.interface]
        if not pnic_before: return None
        cdict = {
            "bytes_sent": (self.pnic.bytes_sent - pnic_before.bytes_sent) / self.divisor,
            "bytes_recv": (self.pnic.bytes_recv - pnic_before.bytes_recv) / self.divisor,
            "packets_sent": self.pnic.packets_sent - pnic_before.packets_sent,
            "packets_recv": self.pnic.packets_recv - pnic_before.packets_recv,
        }
        round_dict(cdict, self.round_size)
        cdict["interface"] = self.interface
        self.output = {
            "full_text": self.format.format(**cdict),
            "instance": self.interface,
        }


status = i3pystatus.Status(standalone=True)

status.register("clock",
    format="%Y-%m-%d %H:%M:%S",)

status.register("weather",
    location_code="AUXX0010",
    format="INN {current_temp}",)

status.register("battery",
    format="B {status}{percentage:.0f}%",
    full_color="#ffffff",
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "",
    },)

status.register(NetworkTraffic,
    interface="eth0",)

status.register("load",
    format="L {avg1} {avg5}",)

status.register("temp",
    format="{temp:.0f}°C",)

status.register("cpu_usage",
    format="CPU {usage}%",)

status.register("mem",
    divisor=1024**3,
    color="#ffffff",
    format="MEM {used_mem}/{total_mem}GB",)

status.register("disk",
    path="/home",
    format="/home ◕ {avail}G",)

status.register("disk",
    path="/",
    format="/ ◕ {avail}G",)


status.run()
