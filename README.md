# HA-MQTT

This is a Helm chart for [HomeAssistant](https://www.home-assistant.io/) with [Mosquitto](https://mosquitto.org/) as a MQTT broker.

Currently the chart supports two optional MQTT services, that integrate into HomeAssistant.

- [ZigBee2MQTT](https://www.zigbee2mqtt.io/)
- [ring-mqtt](https://github.com/tsightler/ring-mqtt)

## Repository

Add the repository:

```bash
helm repo add ha-mqtt https://mcsrobert.github.io/ha-mqtt
```

## Chart

For more information about the chart, including installation, see [the chart](./charts/ha-mqtt/README.md).


## Awknowledgements

Inspired by: [jaygould/home-assistant](https://github.com/jaygould/home-assistant)
