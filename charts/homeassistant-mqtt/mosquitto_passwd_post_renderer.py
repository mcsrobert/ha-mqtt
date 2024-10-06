#! /usr/bin/env python3

"""
Helm post renderer to hash mosquitto passwords.

Reads from stdin and writes the hashed version
to stdout.
"""

from hashlib import pbkdf2_hmac
from base64 import b64encode
import secrets
import fileinput


MANIFEST_SEPARATOR = '---'
SECRET_MATCH_STR = '''
kind: Secret
metadata:
  name: mosquitto-passwd
'''

def read_manifests_from_stdin():
    """ Read from stdin and yield Kubernetes manifests. """
    manifest = ""
    for line in fileinput.input(encoding='utf-8'):
        if line == MANIFEST_SEPARATOR + '\n':
            yield manifest
            manifest = ""
        else:
            manifest += line
    yield manifest


def rewrite_mosquitto_secret():
    """ Find and rewrite the mosquitto manifest. """
    SPLIT_TOKEN = '|-\n'

    has_rewritten = False
    is_first_record = True
    for manifest in read_manifests_from_stdin():
        if is_first_record:
            is_first_record = False
        else:
            print(MANIFEST_SEPARATOR)

        if SECRET_MATCH_STR in manifest:
            metadata, data = manifest.split(SPLIT_TOKEN, maxsplit=1)
            rewritten_manifest = metadata + SPLIT_TOKEN
            for entry in data.split('\n'):
                if entry:
                    username, password = entry.split(':', maxsplit=1)
                    rewritten_manifest += username + ':' + mosquitto_passwd(password) + '\n'
                    has_rewritten = True
            manifest = rewritten_manifest
        print(manifest, end='')

    if not has_rewritten:
        raise RuntimeError("Did not find any password to rewrite!")


def mosquitto_passwd(passwd):
    """" Create mosquitto password hash

    Based on https://stackoverflow.com/a/74247083

    See: https://github.com/eclipse/mosquitto/blob/master/src/password_mosq.h
    """
    iterations = 101
    salt = secrets.token_bytes(12)
    dk = pbkdf2_hmac('sha512', bytes(passwd, 'utf-8'), salt, iterations)
    return (
        "$7$" + str(iterations) +
        "$" + b64encode(salt).decode() +
        "$" + b64encode(dk).decode()
    )


if __name__ == '__main__':
    rewrite_mosquitto_secret()
