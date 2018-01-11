computing-workshop
==================

Environment variables to run the backend:

  * `CW_BACKEND_SMTP_USERNAME`: username for SMTP
  * `CW_BACKEND_SMTP_PASSWORD`: password for SMTP
  * `CW_BACKEND_SMTP_HOSTNAME`: hostname for SMTP
  * `CW_BACKEND_OUT_PATH`: path to the database file
  * `CW_BACKEND_PORT`: port the backend listens on
  * `CW_BACKEND_NOTIFY_RECIPIENTS`: comma-separated list of email addresses to
    send registration email notifications to.

The SMTP server that the backend communicates with must be listening on port
587 and using STARTTLS.
