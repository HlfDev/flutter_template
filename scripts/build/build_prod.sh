#!/bin/bash
echo "🏗️ Building Flutter Template for PRODUCTION"
flutter build apk --flavor production --dart-define=ENVIRONMENT=production --release