import { NativeModule, requireNativeModule } from "react-native"

import {
  CheckoutOptions,
  FlexibleRazorPayModuleEvents,
  SuccessResponse,
} from "./FlexibleRazorPay.types"

declare class FlexibleRazorPayModule extends NativeModule<FlexibleRazorPayModuleEvents> {
  open(options: CheckoutOptions): Promise<SuccessResponse>
}

export default requireNativeModule<FlexibleRazorPayModule>("FlexibleRazorPay")
