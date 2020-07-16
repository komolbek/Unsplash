if [  = "Analyze" ]; then
  if which swiftgen >/dev/null; then
    swiftgen
  else
    echo "warning: Swiftgen not installed, download from https://github.com/SwiftGen/SwiftGen"
    exit 1
  fi
fi
