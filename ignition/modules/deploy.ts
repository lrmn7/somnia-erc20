import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const LRMN = buildModule("LRMN", (m) => {
    const contract = m.contract("LRMN");
    return { contract };
});

module.exports = LRMN;
