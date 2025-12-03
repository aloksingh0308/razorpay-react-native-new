import { NativeModules, NativeEventEmitter } from "react-native";
import type {
  CheckoutOptions,
  FlexibleRazorPayModuleEvents,
  SuccessResponse,
} from "./FlexibleRazorPay.types";

const { FlexibleRazorPay } = NativeModules;

export function openRazorpay(options: CheckoutOptions): Promise<SuccessResponse> {
  return FlexibleRazorPay.open(options);
}

export const RazorpayEvents = new NativeEventEmitter(FlexibleRazorPay);

export default FlexibleRazorPay;
