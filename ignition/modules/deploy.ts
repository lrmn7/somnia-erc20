import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LRMN = buildModule("LRMN", (m) => {
  const contract = m.contract("LRMN", [1000000000000000n]); // Set fee awal 0.001 STT
  return { contract };
});

module.exports = LRMN;
