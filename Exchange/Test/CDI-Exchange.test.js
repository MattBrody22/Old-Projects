const CDItoken = artifacts.require('CDItoken')
const CDIexchange = artifacts.require('CDIexchange')

require('chai')
	.use(require('chai-as-promised'))
	.should()

function tokens(n) {
	return web3.utils.toWei(n, 'ether')
}

contract('CDIexchange', ([exchange, consumer]) => {
	let cditoken, cdiexchange

	before(async()=> {
		cditoken = await CDItoken.new()
		cdiexchange = await CDIexchange.new(cditoken.address)
		await cditoken.transfer(cdiexchange.address, tokens('22000000'))
	})

	describe('CDItoken running', async()=> {
		it('contract CDItoken', async()=> {
			const name = await cditoken.name()
			assert.equal(name, 'Cedar Design Inc Token')
		})
	})

	describe('CDIexchange running', async()=> {
		it('contract CDIexchange', async()=> {
			const name = await cdiexchange.name()
			assert.equal(name, 'Cedar Design Inc Exchange')
		})

		it('contract holds tokens', async()=> {
			let balance = await cditoken.balanceOf(cdiexchange.address)
			assert.equal(balance.toString(), tokens('22000000'))
		})
	})

	describe('purchased()', async()=> {
		let result
		before(async()=>{
			result = await cdiexchange.purchased({from:consumer, value:web3.utils.toWei('1', 'ether')})	
		})

		it('purchased tokens', async()=> {
			let consumerBalance = await cditoken.balanceOf(consumer)
			assert.equal(consumerBalance.toString(), tokens('2000'))

			let cdiexchangeBalance
			cdiexchangeBalance = await cditoken.balanceOf(cdiexchange.address)
			assert.equal(cdiexchangeBalance.toString(), tokens('21998000'))
			cdiexchangeBalance = await web3.eth.getBalance(cdiexchange.address)
			assert.equal(cdiexchangeBalance.toString(), web3.utils.toWei('1', 'ether'))

			const event = result.logs[0].args
			assert.equal(event.consumer, consumer)
			assert.equal(event.cditoken, cditoken.address)
			assert.equal(event.quantity.toString(), tokens('2000').toString())
			assert.equal(event.ratio.toString(), '2000') 
		})
	})

	describe('traded()', async()=> {
		let result
		before(async()=> {
			await cditoken.approve(cdiexchange.address, tokens('2000'), {from:consumer})
			result = await cdiexchange.traded(tokens('2000'), {from:consumer})
		})
		it('trades tokens', async()=> {
			let consumerBalance = await cditoken.balanceOf(consumer)
			assert.equal(consumerBalance.toString(),tokens('0'))

			let cdiexchangeBalance
			cdiexchangeBalance = await cditoken.balanceOf(cdiexchange.address)
			assert.equal(cdiexchangeBalance.toString (), tokens('22000000'))
			cdiexchangeBalance = await web3.eth.getBalance(cdiexchange.address)
			assert.equal(cdiexchangeBalance.toString(), web3.utils.toWei('0', 'ether')) 

			const event = result.logs[0].args
			assert.equal(event.consumer, consumer)
			assert.equal(event.cditoken, cditoken.address)
			assert.equal(event.quantity.toString(), tokens('2000').toString())
			assert.equal(event.ratio.toString(), '2000')
			await cdiexchange.traded(tokens('2000000'), {from:consumer}).should.be.rejected;
		})
	})


})








































