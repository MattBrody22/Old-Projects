const MyFlicks = artifacts.require('MyFlicks');

module.exports = function(deployer) {
	deployer.deploy(MyFlicks);
};