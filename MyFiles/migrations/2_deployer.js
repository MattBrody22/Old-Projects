const MyDocs = artifacts.require('MyDocs');

module.exports = function(deployer) {
	deployer.deploy(MyDocs);
};