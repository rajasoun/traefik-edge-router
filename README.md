# Traefik
-------

Traefik Edge Router and Load Balancer


## Getting Started
------------

0. Prepare a Multipass VM to test in isolation (Optional)

```
./multipass/prepare-multipass.sh
```

3. Place Certificates `ssl_certificate.crt` and `ssl_certificate_key.key`  in `certs` directory 

4. Start the Servies
```
$ ./assist.bash router up
$ ./assist.bash router status
```

5. Teardown

```
./multipass/clean-multipass.sh
```