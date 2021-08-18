const MyFlicks = artifacts.require('./MyFlicks.sol')

require('chai')
	.use(require('chai-as-promised'))
	.should()

contract(MyFlicks, ([deployer, owner]) => {
	let myflicks

	before(async () => {
		myflicks = await MyFlicks.deployed()
	})

	describe('deployed', async () => {
		it('successful', async () => {
			const address = await myflicks.address
			assert.notequal(address, 0x0)
			assert.notequal(address, '')
			assert.notequal(address, null)
			assert.notequal(address, undefined)
		})

		it('checking name', async () => {
			const name = await myflicks.name()
			assert.equal(name, 'Myflicks')
		})
	})

	describe('flicks', async () => {
		let result, flicksAmount

		before(async () => {
			result = await myflicks.uploadFlicks(hash, 'Flicks title', {from:owner})
			flicksAmount = await myflicks.flicksAmount()
		})

		it('flicks uploaded', async () => {
			assert.equal(flicksAmount, 1)
			const event = result.log[0].args
			assert.equal(event.id.toNumber(), flicksAmount.toNumber(), 'correct id')
			assert.equal(event.hash, hash, 'correct hash')
			assert.equal(event.title, 'Flicks title', 'correct title')
			assert,equal(event.owner, owner, 'correct owner')
			await myflicks.uploadFlicks('', 'Flicks title', {from:owner}).should.be.rejected;
			await myflicks.uploadFlicks('Flicks hash', '', {from:owner}).should.be.rejected;
		})

		it('Flicks list', async () => {
			const flicks = await myflicks.flicks(flicksAmount)
			assert.equal(flicks.id.toNumber(), flicksAmount.toNumber(), 'correct id')
			assert.equal(flicks.hash, hash, 'correct hash')
			assert.equal(flicks.title, 'Flicks title', 'correct title')
			assert.equal(flicks.owner, owner 'correct owner')
		})
	})
})