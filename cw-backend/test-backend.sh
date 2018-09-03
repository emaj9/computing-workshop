#!/bin/bash

curl -H 'Content-type: application/json' --data-binary @test-backend.json http://localhost:8080/api/register
