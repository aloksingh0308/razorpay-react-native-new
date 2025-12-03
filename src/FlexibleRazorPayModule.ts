
// import { NativeModules, NativeEventEmitter } from 'react-native';

// const { FlexibleRazorPayModule } = NativeModules;

// if (!FlexibleRazorPayModule) {
//   throw new Error('FlexibleRazorPayModule is not linked. Make sure native code is installed and built.');
// }

// export const FlexibleRazorPayEmitter = new NativeEventEmitter(FlexibleRazorPayModule);

// export default FlexibleRazorPayModule;

// src/FlexibleRazorPayModule.ts
import { NativeModules, NativeEventEmitter } from 'react-native';

const { FlexibleRazorPayModule } = NativeModules;

if (!FlexibleRazorPayModule) {
  throw new Error(
    'FlexibleRazorPayModule is not linked. Make sure native code is installed and built (pod install, clean build, etc).'
  );
}

export const FlexibleRazorPayEmitter = new NativeEventEmitter(FlexibleRazorPayModule);

export default FlexibleRazorPayModule;
