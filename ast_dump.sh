~/Github/llvm_release/bin/clang \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk \
-I"./Example/Pods/Headers/Public/Peregrine" \
-Iinclude -I./Example/Pods/Headers/Public \
-fmodules \
-fsyntax-only \
-Xclang -ast-dump Example/Peregrine/PeregrineActionTest.m
