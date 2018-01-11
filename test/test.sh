#!/bin/bash

curl --data-binary @test.json -H 'Content-Type: application/json' \
    http://localhost:8080/api/register
