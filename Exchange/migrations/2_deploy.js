const CDItoken = artifacts.require('CDItoken');
const CDIexchange = artifacts.require('CDIexchange');

module.exports = async function(deployer) {
	await deployer.deploy(CDItoken);
	const cditoken = await CDItoken.deployed()

	await deployer.deploy(CDIexchange, cditoken.address);
	const cdiexchange = await CDIexchange.deployed()

	await cditoken.transfer(CDIexchange.address, '22000000000000000000000000')

};