/usr/local/bin/clang \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk \
-include-pch "./Example/Peregrine/PrefixHeader.pch" \
-I"./Peregrine" \
-I"./Example/Pods/Headers/Public" \
-fmodules \
-fsyntax-only \
-Xclang -ast-dump Example/Peregrine/PeregrineActionTest3.m
