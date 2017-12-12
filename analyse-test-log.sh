#!/bin/bash

PROJECT_LOG_PATH=$1

PROJECT_LOGS_PATH=$(dirname "$PROJECT_LOG_PATH")

SUCCESS_KEY="Errors: 0"

FAIL_MESSAGE="Fail"
SUCCESS_MESSAGE="Success"

PROJECT_SUMMARY_PATH="$PROJECT_LOGS_PATH/summary.log"
PROJECT_STATUS_PATH="$PROJECT_LOGS_PATH/status.txt"
echo "Status file: $PROJECT_STATUS_PATH"
echo "Summary file: $PROJECT_SUMMARY_PATH"

OUTPUT=$(tail -n 10 $PROJECT_LOG_PATH)

echo ""
echo "Last section of output:"
echo "------------------------------"
echo $OUTPUT
echo "------------------------------"
echo ""

TIME=$(date +"%Y/%m/%d %I-%M-%p")

if (echo "$OUTPUT" | grep -q "$SUCCESS_KEY")
then
  echo $SUCCESS_MESSAGE
  echo "$SUCCESS_MESSAGE\n$TIME" > $PROJECT_STATUS_PATH
  echo "$SUCCESS_MESSAGE - $TIME" >> $PROJECT_SUMMARY_PATH
else
  echo $FAIL_MESSAGE
  echo "$FAIL_MESSAGE\n$TIME" > $PROJECT_STATUS_PATH
  echo "$FAIL_MESSAGE - $TIME" >> $PROJECT_SUMMARY_PATH
fi
