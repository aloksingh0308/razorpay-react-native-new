// import { NativeModules, NativeEventEmitter } from "react-native";
// import type {
//   CheckoutOptions,
//   FlexibleRazorPayModuleEvents,
//   SuccessResponse,
// } from "./FlexibleRazorPay.types";

// const { FlexibleRazorPay } = NativeModules;

// export function openRazorpay(options: CheckoutOptions): Promise<SuccessResponse> {
//   return FlexibleRazorPay.open(options);
// }

// export const RazorpayEvents = new NativeEventEmitter(FlexibleRazorPay);

// export default FlexibleRazorPay;

import { NativeModules, NativeEventEmitter } from 'react-native';

const { FlexibleRazorPayModule } = NativeModules;

if (!FlexibleRazorPayModule) {
  throw new Error('FlexibleRazorPayModule is not linked. Make sure native code is installed and built.');
}

export const FlexibleRazorPayEmitter = new NativeEventEmitter(FlexibleRazorPayModule);

export default FlexibleRazorPayModule;
