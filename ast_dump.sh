../llvm-project/build/Debug/bin/clang \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk \
-I"./Peregrine" \
-I"./Example/Pods/Headers/Public" \
-fmodules \
-fsyntax-only \
-Xclang -ast-dump Example/Peregrine_Example/ClangPeregrineTest.m
