
# Toy Project: Rails 7 with Docker and Kafka Integration

This is a simple toy project built with Rails 7, Docker, and Kafka integration. The purpose of this project is to demonstrate how to set up a Rails application within a Docker container and integrate it with Kafka. Please note that this is a basic setup and does not include advanced features such as metric tools or error logging. Error messages from the endpoint are sent directly to the frontend for simplicity.

## Endpoint Documentation

### Endpoint: POST /api/v1/kafka/hello_world

**Description:**
This endpoint allows users to send a message to a Kafka topic named "hello_world". The message should be included in the request body as a JSON object with the key "message" containing the string message to be sent to Kafka.

**Request:**

- Method: POST
- Endpoint: /api/v1/kafka/hello_world
- Headers:
  - Content-Type: application/json
- Body:
  ```json
  {
    "message": "Your message here"
  }
  ```
