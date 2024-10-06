# homeassistant-mqtt

A helm chart that deploys Home Assistant with a MQTT server (Mosquitto) and other services that use MQTT (Zigbee2MQTT and ring-mqtt).

These are all also available as Home Assistant addons. This chart was created to allow me to migrate to Kubernetes.

## Install / Upgrade

### Passwords

Mosquitto expects passwords in the password file to be hashed in a certain way <sup>[1](https://mosquitto.org/man/mosquitto_passwd-1.html) [2](https://stackoverflow.com/questions/69036942/ansible-create-sha512-pbkdf2-hash/74247083#74247083) [3](https://github.com/eclipse/mosquitto/blob/master/src/password_mosq.h)</sup>, and this chart allows you to either do that yourself and supply the hashed passwords directly, or they can be hashed for you.

As Helm does not provide the functionality to hash these passwords, we need to use a post render script for this. This script rewrites the manifest before it is applied.

```bash
helm upgrade --install homeassistant-mqtt . --post-renderer mosquitto_passwd_post_renderer.py
```

## Awknowledgements

Inspired by: https://github.com/jaygould/home-assistant
