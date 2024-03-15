# Home Assistant Add-on: Tinc VPN Client

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to `Settings` -> `Add-ons` -> `Add-on Store (Bottom Right)`.

2. Click the 3-dots menu at upper right `...` > `Repositories` and add this repository's URL: [https://github.com/mdzidic/hassio-tinc-vpn-client][repository].

3. Reload the page, scroll to the bottom to find the new repository, and click the new add-on named "Home Assistant Tinc VPN Add-on" (refresh the cache if it doesn't appear).

4. Click `Install` and give it a few minutes to finish downloading.

5. Click the `Configuration` tab, and update configuration variables.

6. Click the `Info` tab, then click on `Start` and give it a few seconds to spin up.

## Configuration

Add-on configuration:

```yaml
  server_name: server01
  server_public_key: paste-server-public-key-base64
  connect_to: tinc-server-fqdn-or-ip
  network_name: tinc0
  server_subnet: 10.0.0.1/32
  client_name: client01
  public_key: paste-client-public-key-base64
  private_key: paste-client-private-key-base64
  client_subnet: 10.0.0.2/32
  client_route: 10.0.0.0/24
  address_family: ipv4
  mode: router
```

### Option: `server_name` (required)

Define server file name, match it with tinc server from `hosts` directory.

### Option: `server_public_key` (required)

Convert server public key to base64 format and fill the field.

### Option: `connect_to` (required)

Specifies which other tinc daemon to connect to on startup.

### Option: `network_name` (required)

The name of your tinc network. 

### Option: `server_subnet` (required)

Copy subnet from tinc server configuration.

### Option `client_name` (required)

Define client file name, match it with tinc server from `hosts` directory.

### Option `public_key` (required)

Convert client public key to base64 format and fill the field.

### Option `private_key` (required)

Convert client private key to base64 format and fill the field.

### Option `client_subnet` (required)

Set subnet for client and match it with tinc server configuration.

### Option `client_route` (required)

Set client network route which will be used for `tinc-up` and `tinc-down` scripts.

### Option `address_family` (required)

This option affects the address family of listening and outgoing sockets.

### Option `mode` (required)

One of "swtich", "router" or hub. 

## Support

Got questions?

In case you've found a bug, please [open an issue on our GitHub][issue].

[issue]: https://github.com/mdzidic/hassio-tinc-vpn-client/issues
[repository]: https://github.com/mdzidic/hassio-tinc-vpn-client
