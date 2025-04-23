#!/bin/bash

# Common Name (CN) for the certificate — change this to match your domain or hostname
CN="odoo.local"

# Output file names
KEY="ecdsa.key"
CRT="ecdsa.crt"

#Validity period in days (365 = 1 year)
DAYS=365

# Generate ECDSA private key using the secp384r1 curve (stronger than prime256v1)
openssl ecparam -name secp384r1 -genkey -noout -out "$KEY"

# Generate self-signed certificate with the specified CN and key
openssl req -new -x509 -key "$KEY" -out "$CRT" -days "$DAYS" -subj "/CN=$CN"

echo "Certificate generated..."
