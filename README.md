# Homepage

This is a Helm chart for [HomeAssistant](https://www.home-assistant.io/) with [Mosquitto](https://mosquitto.org/) as a MQTT broker.

Currently the chart supports two optional MQTT services, that integrate into HomeAssistant.

- [ZigBee2MQTT](https://www.zigbee2mqtt.io/)
- [ring-mqtt](https://github.com/tsightler/ring-mqtt)

## Repository

Add the repository:

```bash
helm repo add churo-helm https://mcsrobert.github.io/homeassistant-mqtt
```

## Chart

For more information about the chart, see [the chart](./charts/homeassistant-mqtt/).


## Awknowledgements

Inspired by: [jaygould/home-assistant](https://github.com/jaygould/home-assistant)
