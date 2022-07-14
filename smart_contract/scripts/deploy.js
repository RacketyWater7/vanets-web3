const main = async () => {
  const Vanets = await hre.ethers.getContractFactory("Vanets");
  const vanets = await Vanets.deploy();

  await vanets.deployed();

  console.log("Vanets deployed to:", vanets.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
};

runMain();
