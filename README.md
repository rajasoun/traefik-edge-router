# Application Load Balancer 
-------

Traefik Edge Router and Load Balancer


## Getting Started
------------

0. Prepare a Multipass VM to test in isolation (Optional)

```
./multipass/prepare-multipass.sh
```

3. Place Certificates `ssl_certificate.crt` and `ssl_certificate_key.key`  in `certs` directory 

4. Configure plausible 
```
cp apps/plausible/config/conf.env.sample apps/plausible/config/conf.env
```

5. Start the Servies
```
$ ./assist.bash router up
$ ./assist.bash router status
```

6. Teardown

```
./multipass/clean-multipass.sh
```