#!/bin/sh

RSROOT=$SRCROOT/BaseProject/Resources

#Assets
"$PODS_ROOT/SwiftGen/bin/swiftgen" \
xcassets -t swift4 "$RSROOT/Assets.xcassets" \
--output "$RSROOT/Assets.swift"

#Localizable
"$PODS_ROOT/SwiftGen/bin/swiftgen" \
strings -t structured-swift4 "$RSROOT/Localizable.strings" \
--output "$RSROOT/L10n.swift"

#Colors
"$PODS_ROOT/SwiftGen/bin/swiftgen" \
colors -t swift4 "$RSROOT/Colors.json" \
--output "$RSROOT/Colors.swift"

#Fonts
"$PODS_ROOT/SwiftGen/bin/swiftgen" \
fonts -t swift4 "$RSROOT/Fonts" \
--output "$RSROOT/Fonts.swift"
