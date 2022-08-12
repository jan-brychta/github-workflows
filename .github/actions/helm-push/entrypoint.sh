#!/bin/sh -l

if [ -z "$IMAGEHUB_URL" ]; then
  echo "WARNING: IMAGEHUB_URL is not set. Using 'https://imagehub.ehealth.exchange/chartrepo/sitka-helm-charts' "
  IMAGEHUB_URL='https://imagehub.ehealth.exchange/chartrepo/sitka-helm-charts'
fi

if [ -z "$WORKING_DIRECTORY" ]; then
  echo "WARNING: WORKING_DIRECTORY is not set. Using './charts'"
  WORKING_DIRECTORY='./charts'
fi

if [ -z "$CHART_NAME" ]; then
  echo "ERROR: CHART_NAME is not set. Quitting."
  exit 1
fi

if [ -z "$IMAGEHUB_USERNAME" ]; then
  echo "ERROR: IMAGEHUB_USERNAME is not set. Quitting."
  exit 1
fi

if [ -z "$IMAGEHUB_PASSWORD" ]; then
  echo "ERROR: IMAGEHUB_PASSWORD is not set. Quitting."
  exit 1
fi

cd ${WORKING_DIRECTORY}/${CHART_NAME}

helm package .
helm cm-push -u ${IMAGEHUB_USERNAME} -p ${IMAGEHUB_PASSWORD} ${CHART_NAME}-*.*.*.tgz ${IMAGEHUB_URL}
