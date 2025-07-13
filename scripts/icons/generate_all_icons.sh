#!/bin/bash
echo "🎨 Generating icons for all flavors..."

echo "📱 Development icons..."
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_dev.yaml

echo "🧪 Staging icons..."
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_staging.yaml

echo "🚀 Production icons..."
flutter pub run flutter_launcher_icons -f flutter_launcher_icons_prod.yaml

echo "✅ All flavor icons generated successfully!"