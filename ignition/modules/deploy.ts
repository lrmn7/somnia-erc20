import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import dotenv from "dotenv";

dotenv.config();

const YourBeFunModule = buildModule("YourBeFunModule", (m) => {
  const initialOwner = process.env.INITIAL_OWNER || "0x90A69de07ADEEDBA5d2f2D0afdc0f4D9aFFcbA4F";
  const recipient = process.env.RECIPIENT || "0x90A69de07ADEEDBA5d2f2D0afdc0f4D9aFFcbA4F";
  const fee = m.getParameter("fee", 1000000000000000n);

  const YourBeFun = m.contract("YourBeFun", [initialOwner, recipient, fee]);

  return { YourBeFun };
});

export default YourBeFunModule;
