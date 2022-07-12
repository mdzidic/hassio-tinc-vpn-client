# Home Assistant Add-on: Tinc VPN Client

## About

[tinc][tinc] is a Virtual Private Network (VPN) daemon that uses tunneling and encryption to create a secure private network between hosts on the Internet.

## Install Instructions

To use Tinc VPN Client Add-on, you should set up [tinc][tinc] server first.

The second step is to generate tinc keys, eg. `tincd -n tinc0 -K4096`

The third step is to convert keys (public and private) to base64 format, eg. `cat /etc/tinc/rsa_key.priv | base64 -w 0`

The fourth step is to install Tinc VPN Client Add-on and configure it before starting.

See the [Documentation][docs] tab for further details.

[tinc]: https://www.tinc-vpn.org/
[docs]: ./documentation