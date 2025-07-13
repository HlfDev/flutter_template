#!/bin/bash
echo "🏗️ Building Flutter Template for STAGING"
flutter build apk --flavor staging --dart-define=ENVIRONMENT=staging