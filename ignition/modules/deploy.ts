import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import dotenv from "dotenv";

dotenv.config(); // Load variabel dari .env

const TehGelasModule = buildModule("TehGelasModule", (m) => {
  const initialOwner = process.env.INITIAL_OWNER || "0x0000000000000000000000000000000000000000";
  const recipient = process.env.RECIPIENT || "0x0000000000000000000000000000000000000000";
  const fee = m.getParameter("fee", 1000000000000000n);

  const tehGelas = m.contract("TehGelas", [initialOwner, recipient, fee]);

  return { tehGelas };
});

export default TehGelasModule;
